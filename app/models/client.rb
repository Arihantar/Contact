# t.string   "salutaion"
# t.string   "name"
class Client < ActiveRecord::Base
  attr_accessible :salutaion, :name
  has_many :contact_infos, :dependent => :destroy
  validates :name, :presence => true
end

def fullname
  self.salutaion + " " + self.name
end
