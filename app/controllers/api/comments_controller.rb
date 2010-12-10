class Api::CommentsController < ApiController
  
  before_filter :find_issue
  
  def create
    @comment = @issue.comments.build(params[:comment])

    respond_to do |format|
      if @comment.save
        format.xml { render :xml => @comment, :status => :created }
      else
        format.xml { render :xml => @comment.errors, :status => :unprocessable_entry }
      end
    end
  end
  
  def update
    @comment = @issue.comments.build(params[:comment])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.xml { head :ok }
      else
        format.xml { render :xml => @comment.errors, :status => :unprocessable_entry }
      end
    end
  end
  
  protected
  
    def find_issue
      @issue = current_product.issues.find(params[:issue_id])
    end
  
end