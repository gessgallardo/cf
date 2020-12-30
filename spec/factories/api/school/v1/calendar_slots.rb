# frozen_string_literal: true

FactoryBot.define do
  factory :api_school_v1_calendar_slot, class: 'Api::School::V1::CalendarSlot' do
    skip_create

    date_time { Faker::Time.between(from: DateTime.current, to: DateTime.current + 1.day) }
    locked { false }

    trait :locked do
      id { Faker::Internet.uuid }
      locked { true }
      student { create(:career_student) }
      description { Faker::Lorem.unique }
    end

    initialize_with { new(attributes) }
  end
end
