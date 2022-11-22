# frozen_string_literal: true

class MenuItem < ApplicationRecord
  has_many :menu_item_prices, dependent: :destroy
  has_one :active_menu_item_price, -> { where active: true }, class_name: 'MenuItemPrice', dependent: :destroy
end
