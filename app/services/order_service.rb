# frozen_string_literal: true

class OrderService
  def create_order(params)
    items = params[:items].map do |item|
      menu_item = MenuItem.find(item[:id])
      quantity = item[:quantity]
      observation = item[:observation]
      OrderItem.new(menu_item: menu_item, quantity: quantity, observation: observation, menu_item_price: menu_item.active_menu_item_price)
    end
    Order.create!(client_name: params[:client_name], items: items)
  end

  def process_intent(session_id, intent, attributes)
    Rails.logger.debug session_id
    order = Order.where(session_id: session_id, pending: true).first_or_initialize
    order.save!
    case intent
    when 'DefaultWelcomeIntent'
      "Order Generated #{order.id}"
    when 'FinishOrder'
      finish_order(order)
    when 'AddMenuItem'
      add_menu_item(order, attributes)
    when 'SeeMenu'
      print_menu
    end
  end

  private

  def finish_order(order)
    order.update!(pending: false)
    "Order finalized\nCurrent Amount:#{order.current_amount}\n#{order.print}"
  end

  def print_menu
    MenuItem.all.map do |menu_item|
      "#{menu_item.title}\t\t- $#{menu_item.active_menu_item_price.price}"
    end.join("\n")
  end

  def add_menu_item(order, attributes)
    return unless attributes['quantity'] && attributes['menuitem']

    Rails.logger.debug attributes['quantity']
    Rails.logger.debug attributes['menuitem']

    quantity = attributes['quantity']
    menu_item_title = attributes['menuitem']

    menu_item_by_title = MenuItem.find_by(title: menu_item_title)
    active_price = menu_item_by_title.active_menu_item_price
    new_menu_item = OrderItem.new(menu_item: menu_item_by_title, quantity: quantity, menu_item_price: active_price)

    order.items << new_menu_item
    order.save!

    "Item #{menu_item_by_title.title} - Quantity: #{quantity} - Price: #{active_price.price}"
  end
end
