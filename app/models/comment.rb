class Comment < ActiveRecord::Base
  belongs_to :article
  validates :body, :length => { :maximum => 250 }
  validates :body, :format => { :with => /^((?!kitten).)*$/ }
  validates_presence_of :article_id
  validates_presence_of :body
  attr_accessible :body
end