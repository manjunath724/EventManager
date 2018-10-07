class CreateJoinTableEventUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :events, :users do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
