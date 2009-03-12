class Admin::PagesController < Admin::AdminController
  protect_from_forgery :only => [:create, :update, :destroy]

  # GET /pages GET /pages.xml
  def index
    quick_list
    id = params[:root].nil? || params[:root].to_i == 0 ? 1 : params[:root].to_i
    @page = Page.find(id)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/1 GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new GET /pages/new.xml
  def new
    parent = Page.find(params[:parent_id])
    @page = Page.new(:parent => parent)
 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
    # TODO: fixme!!
    @attachment = Attachment.new(:page_id => @page.id)
    @attachment.page_id = @page.id
    @meta = Meta.new(:page_id => @page.id)
  end
  
  def meta
    @page = Page.find(params[:id])
    @meta = Meta.new(:page_id => @page.id)
  end
  
  def preview
    @page = Page.find(params[:id])
  end

  # POST /pages POST /pages.xml
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:notice] = 'Página creada'
        format.html { redirect_to :back }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1 PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Página modificada'
        format.html { redirect_to :back }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_meta
    id = params[:element_id][0..-6].to_i
    m = Meta.find(id)
    value = params[:update_value]
    m.update_attribute(:value, value)
    render :text => value
  end
  
  def move_up
    @page = Page.find(params[:id])
    @page.move_higher
    redirect_to :back
  end
  
  def move_down
    @page = Page.find(params[:id])
    @page.move_lower
    redirect_to :back
  end

  # DELETE /pages/1 DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end

  def search
    @term = params[:term]
    if @term == nil || @term.empty?
      redirect_to :back
    else
      quick_list
      @pages = Page.db_search(@term)
    end
  end

  def info
    
  end

  private
  def quick_list
    @quicks = Page.find_all_by_parent_id(1)
    @quicks.insert 0, Page.find(1)
  end
end
  
  