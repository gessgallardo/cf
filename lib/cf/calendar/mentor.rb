module Cf
  module Calendar
    class Mentor < Client
      ENDPOINT = '/mentors'.freeze

      def initialize(id:)
        super

        @id = id
      end

      def agenda
        path = "#{ENDPOINT}/#{@id}/agenda"
        response = self.class.get(path, verify: true)
        parse_body(response)
      end
    end
  end
end
