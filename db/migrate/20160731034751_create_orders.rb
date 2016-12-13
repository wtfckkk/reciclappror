class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :vidrio
      t.integer :carton
      t.integer :lata
      t.integer :plastico
      t.string :address
      t.text :description
      t.string :status
      t.string :assigned
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :facebook, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
