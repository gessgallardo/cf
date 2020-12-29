# frozen_string_literal: true

require 'csv'

module Seeds
  class CareerMentors < Base
    def base_class
      ::Career::Mentor
    end
  end
end
