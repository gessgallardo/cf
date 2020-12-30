# frozen_string_literal: true

class ApplicationController < ActionController::API
  def index
    render json: {}, status: :ok
  end

  # TODO: Move this to API::V1::Controller
  around_action :handle_exceptions
  def handle_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound => e
      status = 404
    rescue ActiveRecord::RecordInvalid => e
      status = 403
    rescue StandardError => e
      status = 500
    end

    handle_error e.to_s, status unless e.instance_of?(NilClass)
  end

  def handle_error(message, status = 500)
    message = message.is_a?(Array) ? message.join('. ') : message
    @errors = { message: message, status: status }
    render json: @errors, status: status
  end
end
