class User < ActiveRecord::Base
  attr_accessible :email, :password

  has_secure_password

  has_many :checkins

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token, if: :email_changed? or :password_changed?

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, if: lambda{ new_record? || !password.nil? }

  def latest_checkin
    checkins.order("created_at DESC").first
  end

  def gravatar_url
    "//gravatar.com/avatar/#{Digest::MD5::hexdigest(email.downcase)}?size=45"
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
