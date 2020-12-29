# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Career::AllocatedCall, type: :model do
  let(:allocated_call) { create(:career_allocated_call) }

  it 'has a valid factory' do
    expect(allocated_call).to be_valid
  end
end
