# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
seed_builders_path = File.expand_path(File.join('lib', 'seeds', '**', '*.rb'))
sorted_seed_builders_files = Dir.glob(seed_builders_path).sort
sorted_seed_builders_files.each { |f| require f } # Load Seeds::Builders

Seeds::CareerMentors.seed
Seeds::CareerStudents.seed
