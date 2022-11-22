# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :items, class_name: 'OrderItem', dependent: :destroy

  def current_amount
    items.map { |item| item.quantity * item.menu_item_price.price }.inject(0, :+)
  end

  def print
    items.all.map do |order_item|
      "#{order_item.menu_item.title}'t- #{order_item.quantity}\t- $#{order_item.menu_item_price.price}"
    end.join("\n")
  end
end
