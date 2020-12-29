# frozen_string_literal: true

class Career::Mentorship < ApplicationRecord
  belongs_to :student
  belongs_to :mentor
end
