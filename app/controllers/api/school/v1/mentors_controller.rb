# frozen_string_literal: true

class Api::School::V1::MentorsController < ApplicationController
  def index
    response = student.mentors.map do |m|
      ::Api::School::V1::Mentor.build(mentor: m, in_time_zone: time_zone_param)
  end

    render json: response, status: :ok
  end

  def availibility
    # TODO: Maybe move in_time_zone to be an stored
    if availibility_params[:date]
      api_mentor.filter_slots_by_date!(
        date: availibility_params[:date],
        in_time_zone: time_zone_param
      )
    end

    render json: api_mentor, status: :ok
  end

  def schedule
    api_mentor.schedule(student: student, date: date_time)
  end

  private

  def api_mentor
    @api_mentor ||= Api::School::V1::Mentor.build(mentor: mentor, in_time_zone: time_zone_param)
  end

  def availibility_params
    params.permit(:date, :time_zone)
  end

  def student_params
    params.permit(:student_id)
  end

  def mentor_params
    params.permit(:id)
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
