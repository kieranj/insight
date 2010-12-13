class Issue < ActiveRecord::Base
  
  Priorities = [ "Low", "Minor", "Major", "Critical" ]
  
  States     = [ "Open", "Closed" ]
  
  belongs_to  :user
  belongs_to  :assignee, :class_name => "User", :foreign_key => :assigned_to
  belongs_to  :contact
  belongs_to  :product
  belongs_to  :category, :class_name => "IssueCategory"
  
  has_many    :comments, :class_name => "IssueComment"
  
  validates_presence_of :subject
  validates_presence_of :body
  validates_presence_of :category
  
  before_create :set_initial_state
  before_create :generate_slug
  
  named_scope :for_contact, lambda { |contact_id|
    { :conditions => [ "contact_id = ?", contact_id ] }
  }
  
  named_scope :by_category, lambda { |category_ids| 
    { :conditions => [ "category_id IN (?)", category_ids ] } 
  }
  
  named_scope :by_priority, lambda { |priority|
    { :conditions => [ "priority IN (?)", priority ] }
  }
  
  named_scope :by_state, lambda { |state|
    { :conditions => [ "state IN (?)", state ] }
  }
  
  named_scope :by_product, lambda { |product_ids|
    { :conditions => [ "product_id IN (?)", product_ids]}
  }
  
  named_scope :public,
    :conditions => [ "private = ?", false ]

  # simple_column_search :name, :match => :middle, :escape => lambda { |query| query.gsub(/[^\w\s\-\.']/, "").strip }
  uses_user_permissions

  acts_as_paranoid
  sortable :by => [ "name ASC", "created_at DESC", "updated_at DESC" ], :default => "created_at DESC"
  
  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20     ; end
  def self.outline  ; "long" ; end
  
  def assigned?
    !assignee.nil?
  end
  
  def name
    subject
  end
  
  protected
  
    def set_initial_state
      self.state = "Open"
    end
    
    def generate_slug
      self.slug = self.subject.downcase.gsub(/ /, "-")
    end
  
end