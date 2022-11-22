# frozen_string_literal: true

require 'google/cloud/dialogflow/v2'

class AssistantService
  def initialize(session_id)
    @project_id = 'hands-up-45a83'
    @session_id = session_id || SecureRandom.uuid
    Rails.logger.debug @session_id
    @session_client = Google::Cloud::Dialogflow::V2::Sessions::Client.new
    @order_service = OrderService.new
  end

  def detect_intent(message)
    params = {
      query_input: { text: { text: message, language_code: 'en-us' } },
      session: @session_client.session_path(project: @project_id, session: @session_id),
      query_params: { session_entity_types: session_entities }
    }

    request = Google::Cloud::Dialogflow::V2::DetectIntentRequest.new(params)
    result = @session_client.detect_intent request

    message = result.query_result.fulfillment_messages&.map(&:text)&.map(&:text)&.join('/n')
    order_result = @order_service.process_intent(@session_id, result.query_result.intent.display_name, result.query_result.parameters)

    { message: message, order_result: order_result }
  end

  private

  def session_entities
    entities = MenuItem.all.map do |menu_item|
      Google::Cloud::Dialogflow::V2::EntityType::Entity.new(
        synonyms: [menu_item.title, menu_item.title.downcase, menu_item.title.upcase, menu_item.title.upcase, menu_item.title.capitalize,
                   menu_item.title.pluralize],
        value: menu_item.title
      )
    end
    session_path = @session_client.session_path(project: @project_id, session: @session_id)
    session_entity = Google::Cloud::Dialogflow::V2::SessionEntityType.new(
      name: "#{session_path}/entityTypes/MenuItem",
      entity_override_mode: Google::Cloud::Dialogflow::V2::SessionEntityType::EntityOverrideMode::ENTITY_OVERRIDE_MODE_OVERRIDE,
      entities: entities
    )
    [session_entity]
  end
end
