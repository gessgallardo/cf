FactoryBot.define do
  factory :career_mentorship, class: 'Career::Mentorship' do
    student { nil }
    mentor { nil }
  end
end
