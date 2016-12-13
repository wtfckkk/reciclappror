class CreateFacebooks < ActiveRecord::Migration
  def change
    create_table :facebooks do |t|
      t.string :code
      t.string :name
      t.string :picture
      t.boolean :notify

      t.timestamps null: false
    end
  end
end
