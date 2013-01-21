class AddOwnerAndCampfireToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :owner_id, :integer
    add_column :projects, :campfire_subdomain, :string
    add_column :projects, :campfire_token, :string
    add_column :projects, :campfire_room, :string
  end
end
