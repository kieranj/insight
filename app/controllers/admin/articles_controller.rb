class Admin::ArticlesController < Admin::ApplicationController
  
  unloadable
  
  helper :articles
  
  before_filter :set_current_tab

  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
    
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @article = Article.new(params[:article])
    respond_to do |format|
      if @article.save
        format.js
        format.xml  { head :ok }
      else
        format.js
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @article = Article.find(params[:id])

    if params[:previous] =~ /(\d+)\z/
      @previous = Article.find($1)
    end

    rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @article
  end
  
  def update
    @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.js
        format.xml  { head :ok }
      else
        format.js
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.js
    end
  end
  
end