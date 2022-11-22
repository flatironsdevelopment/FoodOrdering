# frozen_string_literal: true

class CreateMenuItemPrices < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_item_prices do |t|
      t.float :price
      t.boolean :active
      t.belongs_to :menu_item
      t.timestamps
    end
  end
end
