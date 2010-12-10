Contact.class_eval do
  has_many :contact_products
  has_many :products,
    :through => :contact_products
end