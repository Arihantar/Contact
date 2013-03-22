class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name
  validates :email, :presence => true
  validates :first_name, :presence => true,
  					:length => {:minimum => 2}
  validates :last_name, :presence => true,
  					:length => {:minimum => 2}

end
