require 'rails_helper'

RSpec.describe Api::School::V1::CalendarSlot, type: :model do
  let(:student) { create(:career_student) }
  let(:mentor) { create(:career_mentor, students: [student]) }

  context 'when is not locked' do
    let(:slot) { build(:api_school_v1_calendar_slot) }

    it 'doesnt have a description' do
      expect(slot.description).not_to be_present
    end

    it 'doesnt have a student' do
      expect(slot.student).not_to be_present
    end
  end

  context 'when is locked' do
    let(:career_allocated_call) { create(:career_allocated_call, student: student) }
    let(:slot) { build(:api_school_v1_calendar_slot, :locked, student: student) }

    it 'is actually locked' do
      expect(slot.locked).to eq(true)
    end

    it 'has an uuid' do
      expect(slot.id).to be_present
    end

    it 'has a description' do
      expect(slot.description).to be_present
    end

    it 'is related to an student' do
      expect(slot.student).to be_present
    end
  end

  describe 'self.build' do
    subject(:build) do
      described_class.build(
        agenda: agenda,
        allocated_calls: [create(:career_allocated_call, student: student, mentor: mentor, date_time: date_time)],
        in_time_zone: in_time_zone
      )
    end

    # TODO: Create a factory and stub this
    let(:agenda) do
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
    end
    let(:in_time_zone) { 'UTC' }
    let(:date_time) { agenda[:calendar].first[:date_time].to_datetime.in_time_zone(in_time_zone) }

    it 'builds 3 CalendarSlots' do
      expect(build.count).to be(3)
    end

    it 'has one locked slot' do
      expect(build.count(&:locked)).to eq(1)
    end

    context 'when time_zone change' do
      let(:in_time_zone) { 'America/Mexico_City' }

      it 'shows the requested time_zone' do
        expect(build.first.date_time.time_zone.name).to eq(in_time_zone)
      end
    end
  end
end
