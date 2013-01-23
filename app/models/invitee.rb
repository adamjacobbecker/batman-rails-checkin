class Invitee < ActiveRecord::Base
  attr_accessible :email, :project_id

  belongs_to :project
end
