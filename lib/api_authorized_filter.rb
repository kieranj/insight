class ApiAuthorizedFilter
  
  def before(controller)
    return true unless controller.request.headers["X-ApiKey"]
    controller.current_product = Product.find_by_api_key(controller.request.headers["X-ApiKey"])
  end
  
  def after(controller)
    controller.current_product = nil
  end
  
end