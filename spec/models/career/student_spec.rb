# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Career::Student, type: :model do
  describe 'factories' do
    let(:student) { create(:career_student) }

    it 'has a valid factory' do
      expect(student).to be_valid
    end

    context 'when with_mentors is required' do
      let(:student) { create(:career_student, :with_mentors) }

      it 'has 5 mentors' do
        expect(student.mentors.count).to eq(5)
      end
    end
  end

  # @TODO:
  # - abstract to behive like an user
  describe 'validations' do
    subject(:validated_student) do
      student.valid?
      student
    end

    context 'when the first_name is not present' do
      let(:student) { build(:career_student, first_name: nil) }

      it 'is not valid' do
        expect(validated_student.errors[:first_name]).to include("can't be blank")
      end
    end

    context 'when the last_name is not present' do
      let(:student) { build(:career_student, last_name: nil) }

      it 'is not valid' do
        expect(validated_student.errors[:last_name]).to include("can't be blank")
      end
    end

    context 'when the email is not present' do
      let(:student) { build(:career_student, email: nil) }

      it 'is not valid' do
        expect(validated_student.errors[:email]).to include("can't be blank")
      end
    end
  end
end
