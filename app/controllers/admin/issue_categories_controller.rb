class Admin::IssueCategoriesController < Admin::ApplicationController
  
  unloadable
  
  before_filter :set_current_tab

  def index
    @categories = IssueCategory.all
  end
  
  def new
    @category = IssueCategory.new
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @category = IssueCategory.new(params[:issue_category])
    @category.save
    respond_to do |format|
      format.js 
    end
  end
  
  def edit
    @category = IssueCategory.find(params[:id])

    if params[:previous] =~ /(\d+)\z/
      @previous = IssueCategory.find($1)
    end

    rescue ActiveRecord::RecordNotFound
    @previous ||= $1.to_i
    respond_to_not_found(:js) unless @category
  end
  
  def update
    @category = IssueCategory.find(params[:id])
    @category.update_attributes(params[:issue_category])
    respond_to do |format|
      format.js
    end
  end
  
end