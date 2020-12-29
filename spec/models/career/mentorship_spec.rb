# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Career::Mentorship, type: :model do
  let(:mentorship) { create(:career_mentorship) }

  it 'has a valid factory' do
    expect(mentorship).to be_valid
  end
end
