# frozen_string_literal: true

class Api::School::V1::StudentsController < ApplicationController
  def show
    render json: student, status: :ok
  end

  def student_params
    params.permit(:id)
  end

  def student
    @student ||= Career::Student.find student_params[:id]
  end
end
