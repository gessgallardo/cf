# frozen_string_literal: true

FactoryBot.define do
  factory :career_mentor, class: 'Career::Mentor' do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    time_zone { Time.zone }
    calendar_id { 'random-id' }
  end
end
