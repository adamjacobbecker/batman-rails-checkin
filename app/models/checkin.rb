class Checkin < ActiveRecord::Base
  attr_accessible :body, :date

  def date=(x)
  end
end
