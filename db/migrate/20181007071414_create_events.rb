class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.references :user, foreign_key: true
      t.datetime :start_datetime
      t.datetime :end_datetime

      t.timestamps
    end
  end
end
