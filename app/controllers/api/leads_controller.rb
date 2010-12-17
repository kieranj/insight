class Api::LeadsController < ApiController
  
  def create
    @lead = Lead.new(params[:lead])
    respond_to do |format|
      if @lead.save
        format.xml { render :xml => @lead, :status => :created }
      else
        format.xml { render :xml => @lead.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end