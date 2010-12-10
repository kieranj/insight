class Api::IssuesController < ApiController
  
  def index
    @issues = current_product.issues.public#.by_category(params[:category_id])
    respond_to do |format|
      format.xml { render :xml => @issues.to_xml(:include => [ :contact, :category, :comments ]) }
    end
  end
  
  def show
    respond_to do |format|
      id = params[:id].match(/.*-(\d+)$/)[1]
      xml = current_product.issues.find(id).to_xml(:include => [ :contact, :category, :comments ])
      format.xml { render :xml => xml }
    end
  end
  
  def create
    @issue = current_product.issues.build(params[:issue])
    respond_to do |format|
      if @issue.save
        format.xml { render :xml => @issue, :status => :created, :location => @issue }
      else
        format.xml { render :xml => @issue.errors, :status => :unprocessable_entry }
      end
    end
  end
  
  def update
    @issue = current_product.issues.find(params[:id])
    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.xml { head :ok }
      else
        format.xml { render :xml => @issue.errors, :status => :unprocessable_entry }
      end
    end
  end
  
end