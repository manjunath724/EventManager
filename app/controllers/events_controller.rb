class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :accept]

  # GET /events
  # GET /events.json
  def index
    if params[:user_id].blank?
      @events = Event.all
    else
      date = Date.parse(params[:date]) rescue Date.today
      start_date = (date).beginning_of_day
      end_date = (date).end_of_day
      @events = User.where(id: params[:user_id]).first.events.where(start_datetime: start_date..end_date)
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    redirect_to events_url, notice: 'Not Authorized.' unless @event.user == current_user
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user = current_user

    respond_to do |format|
      if @event.save
        @event.send_notification_emails
        format.html { redirect_to events_url, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept
    @event.event_users.where(user_id: params[:user_id]).update_all(status: Event::STATUSES[:accepted])
    redirect_to events_url, notice: 'Event Accepted'
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.user == current_user
      respond_to do |format|
        existing_user_ids = @event.user_ids
        if @event.update(event_params)
          @event.send_notification_emails(existing_user_ids)
          @event.update_notification_emails(existing_user_ids)
          format.html { redirect_to events_url, notice: 'Event was successfully updated.' }
          format.json { render :show, status: :ok, location: @event }
        else
          format.html { render :edit }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to events_url, notice: 'You are not authorized to modify that event.'
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :description, :start_datetime, :end_datetime, { user_ids: [] })
    end
end
