require 'rails_helper'

RSpec.describe Career::Mentor, type: :model do
  let(:mentor) { create(:career_mentor) }

  it 'has a valid factory' do
    expect(mentor).to be_valid
  end

  describe 'validations' do
    subject(:validated_mentor) do
      mentor.valid?
      mentor
    end

    context 'when the first_name is not present' do
      let(:mentor) { build(:career_mentor, first_name: nil) }

      it 'is not valid' do
        expect(validated_mentor.errors[:first_name]).to include("can't be blank")
      end
    end

    context 'when the last_name is not present' do
      let(:mentor) { build(:career_mentor, last_name: nil) }

      it 'is not valid' do
        expect(validated_mentor.errors[:last_name]).to include("can't be blank")
      end
    end

    context 'when the email is not present' do
      let(:mentor) { build(:career_mentor, email: nil) }

      it 'is not valid' do
        expect(validated_mentor.errors[:email]).to include("can't be blank")
      end
    end
  end
end
