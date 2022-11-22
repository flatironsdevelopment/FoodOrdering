# frozen_string_literal: true

class Api::V1::AssistantController < ApplicationController
  def create
    response = assitant_service.detect_intent(message_params[:message])
    render json: response
  end

  private

  def message_params
    params.require(:data).permit(:session_id, :message)
  end

  def assitant_service
    @assitant_service ||= AssistantService.new(message_params[:session_id])
  end
end
