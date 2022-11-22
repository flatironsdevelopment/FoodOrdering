# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :order
      t.belongs_to :menu_item
      t.belongs_to :menu_item_price
      t.integer :quantity
      t.string :observation
      t.timestamps
    end
  end
end
