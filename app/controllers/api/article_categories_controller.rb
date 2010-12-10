class Api::ArticleCategoriesController < ApiController
  
  def index
    respond_to do |format|
      format.xml { render :xml => current_product.article_categories.to_xml(:include => :articles) }
    end
  end
  
end