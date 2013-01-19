class Checkin < ActiveRecord::Base
  attr_accessible :body, :date

  belongs_to :user
  belongs_to :project

  default_scope order('created_at DESC')

  def date
    created_at.strftime("%Y-%m-%d")
  end

  def date=(x)
  end

  def self.for_date(date, offset = 0)
    startDate = Time.at(date.to_time.to_i - offset)
    endDate = Time.at(date.to_time.to_i - offset + 86399)
    where(created_at: startDate..endDate)
  end
end
