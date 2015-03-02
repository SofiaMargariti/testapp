class CreateVessels < ActiveRecord::Migration
  def change
    create_table :vessels do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.decimal :daily_price, precision: 9, scale: 2
      t.decimal :fee_pc, precision: 5, scale: 2
      t.timestamps null: false
    end
  end
end
