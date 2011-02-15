class Api::CategoriesController < ApiController
  
  def index
    respond_to do |format|
      xml = current_product.issue_categories.to_xml(:include => {
        :issues => {
          :include => {
            :contact => { :only => [ :email, :first_name, :last_name, :id, :username ] }
          }
        }
      })
      logger.error xml
      format.xml { render :xml =>  xml }
    end
  end
  
  def show
    category = current_product.issue_categories.find_by_slug(params[:id])
    respond_to do |format|
      xml = category.to_xml(:include => { 
        :issues => { 
          :include => {
            :contact => { :only => [ :email, :first_name, :last_name, :id, :username ] }, 
            :comments => { :include => :commenter } 
          } 
        }
      })
      format.xml { render :xml => xml }
    end
  end
  
end