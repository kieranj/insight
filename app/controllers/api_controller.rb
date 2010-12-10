class ApiController < ActionController::Base
  
  protect_from_forgery :except => [ :create, :update ]
  
  prepend_around_filter ApiAuthorizedFilter.new
  
  def current_product=(product)
    @current_product = product
  end
  
  def current_product
    @current_product
  end
  
end