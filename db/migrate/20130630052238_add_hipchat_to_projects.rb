class AddHipchatToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hipchat_token, :string
    add_column :projects, :hipchat_room, :string
  end
end
