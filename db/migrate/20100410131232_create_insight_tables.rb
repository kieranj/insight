class CreateInsightTables < ActiveRecord::Migration
  
  def self.up
    create_table(:products) do |t|
      t.string :name
      t.string :api_key
    end
    
    create_table(:issue_categories) do |t|
      t.string     :name
      t.string     :slug
      t.string     :description
      t.references :product
    end
    
    create_table(:issues) do |t|
      t.integer    :assigned_to
      t.string     :priority
      t.string     :state
      t.string     :subject
      t.text       :body
      t.boolean    :private, :default => false
      t.references :product
      t.references :contact
      t.references :category
      t.datetime   :deleted_at
      t.timestamps
    end
    
    add_index :issues, :product_id
    add_index :issues, :category_id
    add_index :issues, :contact_id
    add_index :issues, :assigned_to
    
    create_table(:issue_comments) do |t|
      t.references :commenter, :polymorphic => true
      t.references :issue
      t.string     :title
      t.text       :comment
      t.timestamps
    end
    
    create_table(:article_categories) do |t|
      t.string     :name
      t.string     :slug
      t.string     :description
      t.references :product
    end
      
    create_table(:articles) do |t|
      t.string     :title
      t.string     :slug
      t.text       :body
      t.references :category
      t.references :product
      t.datetime   :deleted_at
      t.timestamps
    end
    
    add_index :articles, :category_id
    add_index :articles, :product_id
    
    create_table(:contact_products) do |t|
      t.references :product
      t.references :contact
    end
    
    add_column :leads, :token, :string
    add_column :leads, :salt,  :string
    
  end
  
  def self.down
    drop_table :products
    drop_table :issues
    drop_table :issue_categories
    drop_table :issue_comments
    drop_table :article_categories
    drop_table :articles
    drop_table :contact_products
  end
  
end