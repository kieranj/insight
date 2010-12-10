class Api::CategoriesController < ApiController
  
  def index
    respond_to do |format|
      format.xml { render :xml => current_product.issue_categories.to_xml(:include => :issues) }
    end
  end
  
  def show
    respond_to do |format|
      format.xml { render :xml => current_product.issue_categories.find_by_slug(params[:id]).to_xml }
    end
  end
  
end