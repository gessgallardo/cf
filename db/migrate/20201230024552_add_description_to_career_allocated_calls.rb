class AddDescriptionToCareerAllocatedCalls < ActiveRecord::Migration[6.1]
  def change
    add_column :career_allocated_calls, :description, :text
  end
end
