class AddUserDetails < ActiveRecord::Migration
  
  def self.up
    add_column :issues, :user_name,  :string
    add_column :issues, :user_email, :string
    
    add_column :issue_comments, :user_name,  :string
    add_column :issue_comments, :user_email, :string
  end
  
end