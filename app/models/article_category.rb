class ArticleCategory < ActiveRecord::Base
  
  has_many   :articles, :foreign_key => "category_id", :order => "updated_at DESC"
  belongs_to :product
  
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_presence_of   :product_id
  
  before_create :generate_slug
  
  protected
  
    def generate_slug
      self.slug = self.name.downcase.gsub(/ /, "-")
    end
  
end