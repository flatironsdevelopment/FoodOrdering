# frozen_string_literal: true

class CreateMenuItems < ActiveRecord::Migration[6.1]
  def change
    create_table :menu_items do |t|
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end
