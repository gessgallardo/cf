class CreateCareerMentors < ActiveRecord::Migration[6.1]
  def change
    create_table :career_mentors, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :time_zone
      t.string :calendar_id

      t.timestamps
    end
  end
end
