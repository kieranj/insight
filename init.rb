require "fat_free_crm"

FatFreeCRM::Plugin.register(:insight, initializer) do
  name         "Fat Free Customer Support and Knowledge Base"
  authors      "Kieran Johnson"
  version      "0.1"
  description  "Fat Free Customer Support and Knowledge Base"
  dependencies :haml
  
  tab          :admin, :text => "Products",           :url => { :controller => "products" }
  tab          :admin, :text => "Issue Cats",         :url => { :controller => "issue_categories" } 
  tab          :admin, :text => "Articles",           :url => { :controller => "articles" }
  tab          :admin, :text => "Article Cats",       :url => { :controller => "article_categories" }
  tab          :main,  :text => "Issues",             :url => { :controller => "issues" }
end

require "api_authorized_filter"