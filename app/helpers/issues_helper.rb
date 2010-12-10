module IssuesHelper
  
  def issue_product_checkbox(product, count)
    checked = (session[:filter_by_product] ? session[:filter_by_product].split(",").include?(product.id) : false)
    check_box_tag("product[]", product.id, checked, :id => product.id, :onclick => remote_function(:url => { :action => :filter }, :with => %Q/"product=" + $$("input[name='product[]']").findAll(function (el) { return el.checked }).pluck("value")/))
  end

  def issue_category_checkbox(category, count)
    checked = (session[:filter_by_category] ? session[:filter_by_category].split(",").include?(category.id) : false)
    check_box_tag("category[]", category.id, checked, :id => category.id, :onclick => remote_function(:url => { :action => :filter }, :with => %Q/"category=" + $$("input[name='category[]']").findAll(function (el) { return el.checked }).pluck("value")/))
  end
  
  def issue_priority_checkbox(priority, count)
    checked = (session[:filter_by_priority] ? session[:filter_by_priority].split(",").include?(priority) : false)
    check_box_tag("priority[]", priority, checked, :id => priority, :onclick => remote_function(:url => { :action => :filter }, :with => %Q/"priority=" + $$("input[name='priority[]']").findAll(function (el) { return el.checked }).pluck("value")/))
  end
  
  def issue_state_checkbox(state, count)
    checked = (session[:filter_by_state] ? session[:filter_by_state].split(",").include?(state) : false)
    check_box_tag("state[]", state, checked, :id => state, :onclick => remote_function(:url => { :action => :filter }, :with => %Q/"state=" + $$("input[name='state[]']").findAll(function (el) { return el.checked }).pluck("value")/))
  end

end