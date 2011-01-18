class Article < ActiveRecord::Base
  
  acts_as_paranoid
  
  belongs_to :product
  belongs_to :category, :class_name => "ArticleCategory"
  
  validates_presence_of   :title
  validates_uniqueness_of :title, :scope => [ :product_id, :category_id ]
  validates_presence_of   :body
  validates_presence_of   :product
  validates_presence_of   :category
  
  before_save :generate_slug
  
  named_scope :latest, lambda { |limit|
    { :order => "created_at DESC", :limit => (limit || 5) }
  }
  
  protected
  
    def generate_slug
      self.slug = self.title.downcase.gsub(/ /, "-")
    end
  
end