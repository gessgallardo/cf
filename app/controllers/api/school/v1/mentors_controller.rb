class Api::School::V1::MentorsController < ApplicationController
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
    @student ||= OpenStruct.new(
      id: student_params[:student_id],
      first_name: 'Gess',
      last_name: 'Gallardo',
      mentors: [1]
    )
  end

  def mentor
    @mentor ||= OpenStruct.new(
      id: mentor_params[:id],
      first_name: agenda[:mentor][:name].split&.first,
      last_name: agenda[:mentor][:name].split&.last,
      students: [student],
      agenda: agenda[:calendar]
    )
  end

  private

  def agenda
    @agenda ||= Cf::Calendar::Mentor.new(id: mentor_params[:id]).agenda
  end
end
