class Api::CategoriesController < ApiController
  
  def index
    respond_to do |format|
      format.xml { render :xml => current_product.issue_categories.to_xml(:include => { :issues => { :include => :contact } } ) }
    end
  end
  
  def show
    category = current_product.issue_categories.find_by_slug(params[:id])
    respond_to do |format|
      xml = category.to_xml(:include => { 
        :issues => { 
          :include => {
            :contact => {}, 
            :comments => { :include => :commenter } 
          } 
        }
      })
      format.xml { render :xml => xml }
    end
  end
  
end