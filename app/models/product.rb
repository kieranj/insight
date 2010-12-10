class Product < ActiveRecord::Base
  
  validates_presence_of   :name
  validates_uniqueness_of :name
  
  has_many :issues
  has_many :issue_categories
  
  has_many :articles
  has_many :article_categories
  
  after_create :generate_api_key
  
  protected
  
    def generate_api_key
      self.api_key = ActiveSupport::SecureRandom.hex(32)
      save
    end
  
end