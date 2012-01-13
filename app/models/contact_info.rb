# t.string   "nature"
# t.string   "display_name"
# t.string   "data"
# t.integer  "client_id"
class ContactInfo < ActiveRecord::Base
  attr_accessible :nature, :display_name, :data, :client_id
  belongs_to :client
  
  validates :nature, :presence => true
  validates :display_name, :presence => true
  validates :data, :presence => true
  validates :data,:length => { :maximum => 11 ,:minimum => 7}, :numericality => {:only_integer => true}, :if => "nature == 'Phone Number'"
  validates :data,:length => { :maximum => 50 ,:minimum => 7}, :if => "nature == 'Address'"
  validates :data,:format => { :with => URI::regexp(%w(http https))} ,:if => "nature == 'Link'"
  validates :data,:format => { :with => /^([a-z0-9_.-]+)@([\da-z.-]+).([a-z.]{2,6})$/ } ,:if => "nature == 'Email'"
  
  
  def infovalidate
    if nature == "Phone Number"
      validates 
    else
      errors.add(:data, 'Numbers only')
    end

    if nature == "Address"
      validates 
    else
      errors.add(:data, 'Address cannot exceeds more then 50 or less then 10.')
    end
    if nature == "Date"
      validates 
    else
      errors.add(data, 'Please Enter Correct date')
    end

    if nature == "Link"
      validates
    else
      errors.add(:data, 'Please Enter a valid link')
    end
    if nature == "Email"
      validates 
    else
      errors.add(:data, 'Please Enter valid E-mail address')
    end
  end
end