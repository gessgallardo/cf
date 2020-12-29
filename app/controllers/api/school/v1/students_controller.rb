class Api::School::V1::StudentsController < ApplicationController
  def show
    student = OpenStruct.new({ id: 1, first_name: 'Gess', last_name: 'Gallardo', mentors: [1] })
    render json: student, status: :ok
  end
end
