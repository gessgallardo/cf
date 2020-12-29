# frozen_string_literal: true

require 'csv'

module Seeds
  class Base
    def self.seed
      new.populate
    end

    def populate
      return if base_class.count != 0
      return unless filepath.exist?

      rows = ::CSV.read(filepath, headers: true)
      hash_rows = rows.map { |x| x.to_h.symbolize_keys }

      base_class.create(hash_rows)
    end

    private

    def base_class
      raise NotImplementedError
    end

    def filepath
      Rails.root.join("lib/assets/#{self.class.name.underscore}.csv")
    end
  end
end
