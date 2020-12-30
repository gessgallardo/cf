# frozen_string_literal: true

FactoryBot.define do
  factory :api_school_v1_mentor, class: 'Api::School::V1::Mentor' do
    skip_create

    id { Faker::Internet.uuid }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    time_zone { Time.zone }

    initialize_with { new(attributes) }
  end
end
