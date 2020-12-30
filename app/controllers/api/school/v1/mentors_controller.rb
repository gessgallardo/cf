# frozen_string_literal: true

class Api::School::V1::MentorsController < ApplicationController
  def index
    response = student.mentors.map do |m|
      ::Api::School::V1::Mentor.build(mentor: m, in_time_zone: time_zone_param)
    end

    render json: response, status: :ok
  end

  def availability
    # TODO: Maybe move in_time_zone to be an stored
    if availability_params[:date]
      api_mentor.filter_slots_by_date!(
        date: availability_params[:date],
        in_time_zone: time_zone_param
      )
    end

    render json: api_mentor, status: :ok
  end

  def schedule
    date_time = schedule_params.fetch(:date_time)
    description = schedule_params.fetch(:description)
    response = api_mentor.schedule(
      student: student,
      date: date_time,
      description: description,
      in_time_zone: time_zone_param
    )

    render json: response, status: :accepted
  end

  private

  def api_mentor
    @api_mentor ||= Api::School::V1::Mentor.build(mentor: mentor, in_time_zone: time_zone_param)
  end

  def availability_params
    params.permit(:date, :time_zone)
  end

  def student_params
    params.permit(:student_id)
  end

  def mentor_params
    params.permit(:id)
  end

  def schedule_params
    params.permit(:date_time, :description)
  end

  def time_zone_param
    params.permit(:time_zone).fetch(:time_zone, 'UTC')
  end

  def student
    @student ||= Career::Student.find student_params[:student_id]
  end

  def mentor
    @mentor ||= student.mentors.find mentor_params[:id]
  end
end
