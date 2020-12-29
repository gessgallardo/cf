module Cf
  class Client
    include HTTParty

    base_uri 'private-37dacc-cfcalendar.apiary-mock.com'

    def initialize(_args) end

    def parse_body(response)
      JSON.parse response.body, symbolize_names: true
    rescue JSON::ParserError => e
      { error: e.message, status: response.code }
    rescue StandardError => e
      { error: e.message, status: :internal_server_error }
    end
  end
end
