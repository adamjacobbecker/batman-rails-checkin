class Project < ActiveRecord::Base
  attr_accessible :name

  has_many :checkins
  has_and_belongs_to_many :users
end
