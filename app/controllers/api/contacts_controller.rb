class Api::ContactsController < ApiController
  
  def show
    @contact = Contact.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @contact }
    end
  end
  
  def email
    @contact = Contact.find_by_email(params[:email])
    respond_to do |format|
      format.xml { render :xml => @contact }
    end
  end
  
  def create
    @contact = Contact.new(params[:contact])
    respond_to do |format|
      if @contact.save
        format.xml { render :xml => @contact, :status => :created }
      else
        format.xml { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @contact = Contact.find(params[:id])
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.xml { head :ok }
      else
        format.xml { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end