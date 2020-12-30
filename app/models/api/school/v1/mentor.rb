# frozen_string_literal: true

module Api
  module School
    module V1
      class Mentor
        attr_reader :id, :first_name, :last_name, :email, :time_zone, :calendar_slots

        class << self
          # Builds a API::School::V1::Mentor given a calendar client
          # and a mentor  for given date in a time zone
          def build(mentor:, calendar_client: ::Cf::Calendar::Mentor, in_time_zone: 'UTC')
            agenda = calendar_client.new(id: mentor.calendar_id).agenda
            calendar_slots = Api::School::V1::CalendarSlot.build(
              allocated_calls: mentor.allocated_calls,
              agenda: agenda,
              in_time_zone: in_time_zone
            )

            # Persist if time_zone has changed
            mentor.time_zone = agenda.dig(:mentor, :time_zone)
            mentor.save! if mentor.changed?

            new(mentor: mentor, calendar_slots: calendar_slots)
          end
        end

        def initialize(mentor:, calendar_slots:)
          @id = mentor.id
          @first_name = mentor.first_name
          @last_name = mentor.last_name
          @time_zone = mentor.time_zone
          @email = mentor.email
          @calendar_slots = calendar_slots
        end

        def filter_slots_by_date!(date:, in_time_zone: 'UTC')
          # convert time to the requested time_zone always default to UTC
          date_time = date.to_date.in_time_zone(in_time_zone)
          eod = date_time.end_of_day
          bod = date_time.beginning_of_day
          # raise StandardError.new(message: 'date cannot be in past') if eod.past?

          @calendar_slots.select! do |calendar_slot|
            calendar_slot.date_time.between?(bod, eod)
          end
        end

        def schedule(_student:, _date:)
          raise NotImplementedError
        end
      end
    end
  end
end
