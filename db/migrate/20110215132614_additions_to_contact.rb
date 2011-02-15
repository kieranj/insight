class AdditionsToContact < ActiveRecord::Migration
  
  def self.up
    add_column :contacts, :username,  :string
  end
  
end