class Api::AccountsController < ApiController
  
  def show
    @account = Account.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @account }
    end
  end
  
  def create
    @account = Account.new(params[:account])
    respond_to do |format|
      if @account.save
        format.xml { render :xml => @account, :status => :created, :location => @account }
      else
        format.xml { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @account = Account.find(params[:id])
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.xml { head :ok }
      else
        format.xml { render :xml => @account.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end