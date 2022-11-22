# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :session_id
      t.boolean :pending, default: true
      t.timestamps
    end
  end
end
