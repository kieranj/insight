class IssuesController < ApplicationController
  
  unloadable

  before_filter :require_user
  before_filter :set_current_tab, :only => [ :index, :show ]

  before_filter :get_data_for_sidebar, :only => :index
  before_filter :attach, :only => :attach
  before_filter :discard, :only => :discard
  before_filter :auto_complete, :only => :auto_complete
  after_filter  :update_recently_viewed, :only => :show
  
  
  def index
    @issues = get_issues(:page => params[:page])
  end
  
  def show
    @issue    = Issue.find(params[:id])
    @comment  = Comment.new
  end
  
  def edit
    @issue = Issue.find(params[:id])
    @users = User.except(current_user).all
    
    if params[:previous] =~ /(\d+)\z/
      @previous = Issue.my(@current_user).find($1)
    end
    
    respond_to do |format|
      format.js
    end
    
    rescue ActiveRecord::RecordNotFound
      @previous ||= $1.to_i
      respond_to_not_found(:js) unless @issue
  end
  
  def update
    @issue = Issue.find(params[:id])
    @issue.update_attributes(params[:issue])
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy if @issue
    
    respond_to do |format|
      format.html { respond_to_destroy(:html) }
      format.js   { respond_to_destroy(:ajax) }
      format.xml  { head :ok }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:html, :js, :xml)
  end
  
  def filter
    session[:filter_by_category] = params[:category]
    session[:filter_by_priority] = params[:priority]
    session[:filter_by_product]  = params[:product]
    session[:filter_by_product]  = params[:state]
    @issues = get_issues
    respond_to do |format|
      format.js
    end
  end
  
  protected
  
    def get_issues(options = {})
      self.current_page  = options[:page] if options[:page]
      self.current_query = options[:query] if options[:query]

      records = {
        :order => Issue.sort_by
      }
      pages = {
        :page     => current_page,
        :per_page => 20
      }
      
      q = Issue.scoped({})
      
      if session[:filter_by_product]
        filtered_products = session[:filter_by_product].split(",")
        q = q.by_product(filtered_products) if !filtered_products.empty?
      end

      if session[:filter_by_category]
        filtered_categories = session[:filter_by_category].split(",")
        q = q.by_category(filtered_categories) if !filtered_categories.empty?
      end
      
      if session[:filter_by_priority]
        filtered_prorities  = session[:filter_by_priority].split(",") 
        q = q.by_priority(filtered_prorities) if !filtered_prorities.empty?
      end
      
      if session[:filter_by_state]
        filtered_states  = session[:filter_by_state].split(",") 
        q = q.by_state(filtered_states) if !filtered_states.empty?
      end
        
      q = (current_query.blank? ? q : query.search(current_query))

      q = q.paginate(pages)
      q
    end
  
    def get_data_for_sidebar(related = false)
      if related
        instance_variable_set("@#{related}", @issue.send(related)) if called_from_landing_page?(related.to_s.pluralize)
      else
        @issue_category_total = { :all => Issue.all.count, :other => 0 }
        IssueCategory.find_each do |category|
          @issue_category_total[category.id]      = Issue.all.count(:conditions => [ "category_id=?", category.id ])
          @issue_category_total[:other] -= @issue_category_total[category.id]
        end
        @issue_category_total[:other] += @issue_category_total[:all]
      end
    end
    
    def respond_to_destroy(method)
      if method == :ajax
        if called_from_index_page?
          @issues = get_issues
          if @issues.blank?
            @issues = get_issues(:page => current_page - 1) if current_page > 1
            render :action => :index and return
          end
        else
          self.current_page = 1
        end
        # At this point render destroy.js.rjs
      else
        self.current_page = 1
        flash[:notice] = t(:msg_asset_deleted, @issue.subject)
        redirect_to(issues_path)
      end
    end
  
end