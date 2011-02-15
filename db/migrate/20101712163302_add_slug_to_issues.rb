class AddSlugToIssues < ActiveRecord::Migration
  
  def self.up
    add_column :issues, :slug,  :string
  end
  
end