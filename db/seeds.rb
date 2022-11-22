# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MenuItem.create!(title: "Coke", active_menu_item_price: MenuItemPrice.new(price: 5, active: true))
MenuItem.create!(title: "Hot Dog", active_menu_item_price: MenuItemPrice.new(price: 20, active: true))
MenuItem.create!(title: "Burger", active_menu_item_price: MenuItemPrice.new(price: 25, active: true))
MenuItem.create!(title: "Pasta", active_menu_item_price: MenuItemPrice.new(price: 18, active: true))
MenuItem.create!(title: "Sushi", active_menu_item_price: MenuItemPrice.new(price: 23, active: true))
MenuItem.create!(title: "Juice", active_menu_item_price: MenuItemPrice.new(price: 10, active: true))
