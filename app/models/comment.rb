    # t.string   "commenter"
    # t.text     "body"
class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :commenter
  validates :body, :commenter, :presence => true, :length => {:minimum => 5}
  

end
