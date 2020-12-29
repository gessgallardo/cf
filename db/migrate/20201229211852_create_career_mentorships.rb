class CreateCareerMentorships < ActiveRecord::Migration[6.1]
  def change
    create_table :career_mentorships, id: :uuid do |t|
      t.references :student, type: :uuid, index:true, null: false, foreing_key: { from_table: :career_student }
      t.references :mentor, type: :uuid, index:true, null: false, foreing_key: { from_table: :career_mentor }

      t.timestamps
    end
  end
end
