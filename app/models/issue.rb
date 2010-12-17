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
  after_create  :create_lead, :if => :contact_not_present
  
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
  
  def email
    contact.nil? ? user_email : contact.email
  end
  
  def by
    contact.nil? ? user_name : contact.full_name
  end
  
  protected
  
    def contact_not_present
      contact_id.nil?
    end
  
    def set_initial_state
      self.state = "Open"
    end
    
    def generate_slug
      self.slug = self.subject.downcase.gsub(/ /, "-")
    end
    
    def create_lead
      Lead.create({
        :first_name  => user_name.split(" ", 2)[0],
        :last_name   => user_name.split(" ", 2)[1],
        :email       => user_email,
        :assigned_to => 1, 
        :source      => "Insight"
      })
    end
  
end