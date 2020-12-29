# frozen_string_literal: true

require 'csv'

module Seeds
  class CareerStudents < Base
    def base_class
      ::Career::Student
    end
  end
end
