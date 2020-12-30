# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::School::V1::Mentor, type: :model do
  subject(:api_mentor) do
    described_class.build(
      mentor: mentor,
      in_time_zone: in_time_zone,
      calendar_client: calendar_client
    )
  end

  let!(:student) { create(:career_student) }
  let!(:mentor) { create(:career_mentor, students: [student]) }
  let!(:allocated_call) do # rubocop:disable RSpec/LetSetup
    create(
      :career_allocated_call,
      student: student,
      mentor: mentor,
      date_time: '2020-10-24 17:10:09 +0200'.to_datetime.in_time_zone(in_time_zone)
    )
  end
  let(:in_time_zone) { 'UTC' }
  let(:calendar_client) do
    class_double('StubbedApi')
  end

  before do
    allow(calendar_client).to receive(:new).with({ id: mentor.calendar_id }).and_return(calendar_client)
    allow(calendar_client).to receive(:agenda).and_return(
      {
        mentor: {
          name: "#{mentor.first_name} #{mentor.last_name}",
          time_zone: mentor.time_zone
        },
        calendar: [
          { date_time: '2020-10-24 17:10:09 +0200' },
          { date_time: '2020-10-25 13:11:55 +0100' },
          { date_time: '2020-10-26 23:43:20 +0100' }
        ]
      }
    )
  end

  describe 'self.build' do
    it 'builds 3 CalendarSlots' do
      expect(api_mentor.calendar_slots.count).to be(3)
    end

    it 'has one locked slot' do
      expect(api_mentor.calendar_slots.count(&:locked)).to eq(1)
    end

    context 'when time_zone change' do
      let(:in_time_zone) { 'America/Mexico_City' }

      it 'shows the requested time_zone' do
        expect(api_mentor.calendar_slots.first.date_time.time_zone.name).to eq(in_time_zone)
      end
    end
  end

  describe '#filter_slots_by_date!' do
    let(:date) { '2020-10-24' }
    let(:expected_response) { '2020-10-24 17:10:09 +0200' }

    it 'filters correctly for a given time' do
      expect {
        api_mentor.filter_slots_by_date!(date: date)
      }.to change {
        api_mentor.calendar_slots.count
      }.from(3).to(1)
    end

    it 'returns the correct result' do
      api_mentor.filter_slots_by_date!(date: date)
      expect(api_mentor.calendar_slots.first.date_time).to eq(expected_response)
    end

    context 'when time_zone changes' do
      subject(:filter_slots_by_date) do
        api_mentor.filter_slots_by_date!(
          date: date,
          in_time_zone: in_time_zone
        )
      end

      let(:date) { '2020-10-25' }
      let(:in_time_zone) { 'Asia/Tokyo' }
      let(:expected_response) { '2020-10-25 00:10:09.000000000 +0900' }

      it 'filters correctly for a given time and time_zone' do
        expect {
          filter_slots_by_date
        }.to change {
          api_mentor.calendar_slots.count
        }.from(3).to(2)
      end

      it 'returns the correct result' do
        expect(filter_slots_by_date.first.date_time).to eq(expected_response)
      end
    end
  end
end
