class IssueComment < ActiveRecord::Base
  
  belongs_to :issue
  belongs_to :commenter, :polymorphic => true
  
  def user_name
    if !commenter.nil?
      commenter.full_name
    else
      super
    end
  end
  
  def user_email
    if !commenter.nil?
      commenter.email
    else
      super
    end
  end
  
  alias :email :user_email
  
end