class AddCodeToInvitee < ActiveRecord::Migration
  def change
    add_column :invitees, :invite_code, :string
  end
end
