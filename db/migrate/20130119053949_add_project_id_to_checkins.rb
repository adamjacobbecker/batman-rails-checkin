class AddProjectIdToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :project_id, :integer
  end
end
