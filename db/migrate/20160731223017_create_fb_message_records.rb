class CreateFbMessageRecords < ActiveRecord::Migration
  def change
    create_table :fb_message_records do |t|
      t.string :mid
      t.text :text
      t.string :sender

      t.timestamps null: false
    end
  end
end
