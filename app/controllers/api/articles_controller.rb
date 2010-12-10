class Api::ArticlesController < ApiController
  
  before_filter :find_article_category, :only => [ :index ]
  
  def index
    respond_to do |format|
      format.xml { render :xml => @category.articles.to_xml }
    end
  end
  
  def show
    respond_to do |format|
      format.xml { render :xml => current_product.articles.find_by_slug(params[:id]).to_xml }
    end
  end
  
  protected
  
    def find_article_category
      @category = current_product.article_categories.find_by_slug(params[:category_id])
    end
  
end