class IssueCategory < ActiveRecord::Base
  
  acts_as_url :name, :url_attribute => :slug
  
  has_many   :issues, :foreign_key => "category_id"
  belongs_to :product
  
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_presence_of   :product_id
  
end