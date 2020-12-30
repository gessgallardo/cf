module Api
  module School
    module V1
      class CalendarSlot
        attr_reader :id, :date_time, :locked, :student, :description

        class << self
          # Builds API::School::V1::CalendarSlots given a calendar client
          # and a mentor calls
          # TODO: Abstract this method
          def build(agenda:, allocated_calls: [], in_time_zone: 'UTC') # rubocop:disable Metrics/MethodLength
            utc_slots = slots_to_timezone(slots: agenda[:calendar], in_time_zone: in_time_zone)
            utc_slots.map do |utc_time_slot|
              allocated_slot = allocated_calls.find { |x| x.date_time == utc_time_slot }
              if allocated_slot
                new(
                  id: allocated_slot.id,
                  date_time: allocated_slot.date_time.in_time_zone(in_time_zone),
                  locked: true,
                  student: allocated_slot.student,
                  description: allocated_slot.description
                )
              else
                new(date_time: utc_time_slot)
              end
            end
          end

          def slots_to_timezone(slots: [], in_time_zone: 'UTC')
            slots.map { |x| x[:date_time].to_time.in_time_zone(in_time_zone) }
          end
        end

        def initialize(date_time:, id: nil, locked: false, student: nil, description: nil)
          @id = id
          @date_time = date_time
          @locked = locked
          @student = student
          @description = description
        end
      end
    end
  end
end
