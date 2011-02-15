class AdditionsToContact < ActiveRecord::Migration
  
  def self.up
    add_column :contact, :username,  :string
  end
  
end