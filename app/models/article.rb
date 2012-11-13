class Article < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates_presence_of :title, :body
  validates :body, :format => { :with => /^((?!kitten).)*$/ }
  attr_accessible :body, :title
end
