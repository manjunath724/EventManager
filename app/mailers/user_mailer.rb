class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def event_added(event_id, user_id)
    @event = Event.find(event_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Event Added')
  end

  def event_modified(event_id, user_id)
    @event = Event.find(event_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: 'Event Modified')
  end
end
