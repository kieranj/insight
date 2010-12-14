class Api::CommentsController < ApiController
  
  before_filter :find_issue

  def create
    @comment = @issue.comments.build(params[:comment])

    respond_to do |format|
      if @comment.save
        format.xml { render :xml => @comment.to_xml(:include => [:issue, :commenter]), :status => :created }
      else
        format.xml { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @comment = @issue.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.xml { head :ok }
      else
        format.xml { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  protected
  
    def find_issue
      id     = params[:issue_id].match(/.*-(\d+)$/)[1]
      @issue = current_product.issues.find(id)
    end
  
end