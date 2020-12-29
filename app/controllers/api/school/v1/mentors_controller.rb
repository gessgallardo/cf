# frozen_string_literal: true

class Api::School::V1::MentorsController < ApplicationController
  def index
    render json: student&.mentors, status: :ok
  end

  def show
    render json: mentor.as_json, status: :ok
  end

  def student_params
    params.permit(:student_id)
  end

  def mentor_params
    params.permit(:id)
  end

  def student
    @student ||= Career::Student.find student_params[:student_id]
  end

  def mentor
    @mentor ||= Career::Mentor.find student_params[:id]
  end

  private

  def agenda
    @agenda ||= Cf::Calendar::Mentor.new(id: mentor.calendar_id).agenda
  end
end
