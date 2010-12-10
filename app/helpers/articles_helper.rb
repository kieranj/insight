module ArticlesHelper
  
  def link_to_delete(model)
    name = model.class.name.underscore.downcase
    link_to_remote(t(:delete),
      :method => :delete,
      :url    => send("admin_#{name}_path", model),
      :with   => "{ previous: crm.find_form('edit_#{name}') }"
    )
  end
  
end