FactoryBot.define do
  factory :career_student, class: 'Career::Student' do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    time_zone { Time.zone }
  end
end
