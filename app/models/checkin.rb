class Checkin < ActiveRecord::Base
  attr_accessible :body, :date

  belongs_to :user

  def date=(x)
  end
end
