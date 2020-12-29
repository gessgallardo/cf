# frozen_string_literal: true

class ApplicationController < ActionController::API
  def index
    mentor = Cf::Calendar::Mentor.new(id: 1)

    render json: mentor.agenda, status: :ok
  end
end
