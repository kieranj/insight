class Admin::ArticleCategoriesController < Admin::ApplicationController
  
  unloadable
  
  before_filter :set_current_tab

  def index
    @categories = ArticleCategory.all
  end
  
  def new
    @category = ArticleCategory.new
    
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @category = ArticleCategory.new(params[:article_category])
    @category.save
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @category = ArticleCategory.find(params[:id])

    if params[:previous] =~ /(\d+)\z/
      @previous = ArticleCategory.find($1)
    end

    rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @category
  end
  
  def update
    @category = ArticleCategory.find(params[:id])
    @category.update_attributes(params[:article_category])
    respond_to do |format|
      format.js
    end
  end
  
end