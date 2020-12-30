# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::School::V1::Mentors', type: :request do
  let!(:student) { create(:career_student) }
  let!(:mentor) do
    create(
      :career_mentor,
      first_name: 'Max',
      last_name: 'Mustermann',
      calendar_id: '1',
      time_zone: '-03:00',
      students: [student]
    )
  end
  let!(:allocated_call) do
    create(
      :career_allocated_call,
      student: student,
      mentor: mentor,
      date_time: '2020-10-24 17:10:09 +0200'.to_datetime.in_time_zone(in_time_zone)
    )
  end
  let(:in_time_zone) { 'UTC' }
  let(:datetime_one) { '2020-10-25T12:11:55.000Z' }
  let(:datetime_two) { '2020-10-26T22:43:20.000Z' }
  let(:datetime_three) { '2020-10-24T15:10:09.000Z' }
  let(:calendar_slots) do
    [
      {
        id: allocated_call.id,
        date_time: datetime_three,
        locked: true,
        student: student.as_json,
        description: allocated_call.description
      },
      { id: nil, date_time: datetime_one, locked: false, student: nil, description: nil },
      { id: nil, date_time: datetime_two, locked: false, student: nil, description: nil }
    ]
  end

  describe 'POST /api/school/v1/students/:student_id/mentors/:id/schedule' do
    subject(:trigger_request) do
      VCR.use_cassette('post_cf_calendar_api') do
        post schedule_api_school_v1_student_mentor_path(id: mentor.id, student_id: student.id), params: params.as_json
      end
    end

    let(:params) do
      {
        date_time: datetime_one,
        description: 'WE NEED TO TALK!'
      }
    end

    it 'creates an allocated_call with a correct description' do
      trigger_request
      response_body = JSON.parse(response.body)

      expect(response_body.fetch('description')).to eq params[:description]
    end

    it 'creates an allocated_call with a correct datetime' do
      trigger_request
      response_body = JSON.parse(response.body)

      expect(response_body.fetch('date_time')).to eq params[:date_time]
    end

    it 'is assigned to correct student' do
      trigger_request
      response_body = JSON.parse(response.body)

      expect(response_body.fetch('student_id')).to eq student.id
    end

    context 'when the date has already been allocated' do
      let(:params) do
        {
          date_time: datetime_three,
          description: 'WE NEED TO TALK!'
        }
      end
      let(:expected_response) do
        {
          message: 'time slot that has already been allocated to a call',
          status: 500
        }.as_json
      end

      it 'raises a proper error' do
        trigger_request
        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response)
      end
    end

    context 'when the date cannot be found' do
      let(:params) do
        {
          date_time: '2050-10-24T15:10:09.000Z',
          description: 'WE NEED TO TALK!'
        }
      end
      let(:expected_response) do
        {
          message: 'time slot cannot be found',
          status: 500
        }.as_json
      end

      it 'raises a proper error' do
        trigger_request
        response_body = JSON.parse(response.body)

        expect(response_body).to eq(expected_response)
      end
    end
  end

  describe 'GET /api/school/v1/students/:student_id/mentors/:id/availibility' do
    subject(:trigger_request) do
      VCR.use_cassette('cf_calendar_api') do
        get availibility_api_school_v1_student_mentor_path(id: mentor.id, student_id: student.id)
      end
    end

    let(:expected_response) do
      {
        id: mentor.id,
        first_name: mentor.first_name,
        last_name: mentor.last_name,
        time_zone: mentor.time_zone,
        email: mentor.email,
        calendar_slots: calendar_slots
      }.as_json
    end

    it 'returns the proper response code' do
      trigger_request

      expect(response).to have_http_status(:ok)
    end

    it 'shows mentor availablity' do
      trigger_request
      expect(JSON.parse(response.body)).to eq expected_response
    end

    context 'when date is included' do
      subject(:trigger_request) do
        VCR.use_cassette('api_school_v1_students_student_id_mentors_id_availibility') do
          get availibility_api_school_v1_student_mentor_path(id: mentor.id, student_id: student.id, date: '2020-10-24')
        end
      end

      let(:calendar_slots) do
        [
          {
            id: allocated_call.id,
            date_time: datetime_three,
            locked: true,
            student: student.as_json,
            description: allocated_call.description
          }
        ]
      end

      it 'shows mentor availablity for specific date' do
        trigger_request
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end
  end
end
