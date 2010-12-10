class IssueCommentsController < ApplicationController
  
  before_filter :require_user
  before_filter :find_issue
  
  def index
  end
  
  def new
    @comment = @issue.comments.build
    if params[:cancel].true?
      session.delete("issue_new_comment")
    else
      session["issue_new_comment"] = true
    end
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @comment = @issue.comments.build(params[:comment])
    @comment.commenter = current_user
    @comment.save
    respond_to do |format|
      format.js
    end
  end
  
  def edit
    @comment = @issue.comments.find(params[:id])
    respond_to do |format|
      format.js
    end
  end
  
  def update
    @comment = @issue.comments.find(params[:id])
    @comment.update_attributes(params[:issue_comment])
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @comment = @issue.comments.find(params[:id])
    @comment.destroy if @comment
    respond_to do |format|
      format.js
    end
  end
  
  protected
  
    def find_issue
      @issue = Issue.find(params[:issue_id])
    end
  
end