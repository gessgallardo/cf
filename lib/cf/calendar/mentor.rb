# frozen_string_literal: true

module Cf
  module Calendar
    class Mentor < Client
      ENDPOINT = '/mentors'

      def initialize(id:)
        super

        @id = id
      end

      # TODO: add error handling
      def agenda
        path = "#{ENDPOINT}/#{@id}/agenda"
        response = self.class.get(path, verify: true)
        parse_body(response)
      end
    end
  end
end
