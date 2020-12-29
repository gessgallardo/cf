class CreateCareerStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :career_students, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :time_zone
      t.string :email

      t.timestamps
    end
  end
end
