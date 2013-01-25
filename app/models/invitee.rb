class Invitee < ActiveRecord::Base
  attr_accessible :email, :project_id

  belongs_to :project

  before_create :generate_invite_code

  def self.associate_invites_with_user_by_email(user, email = nil)
    email = user.email unless email

    Invitee.where(email: email).each do |invitee|
      user.projects << Project.find(invitee.project_id)
      invitee.destroy
    end
  end

  def self.associate_invites_with_user_by_invite_code(user, invite_code)
    invitee = Invitee.where(invite_code: invite_code).first
    return unless invitee
    email = invitee.email
    self.associate_invites_with_user_by_email(user, email)
  end

  private

  def generate_invite_code
    self.invite_code = SecureRandom.hex(4)
  end
end
