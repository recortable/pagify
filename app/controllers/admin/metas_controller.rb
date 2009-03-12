
class Admin::MetasController < Admin::AdminController
  
  # GET /metas GET /metas.xml
  def index
    @metas = @page.metas

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @metas }
    end
  end

  # GET /metas/1 GET /metas/1.xml
  def show
    @meta = @page.meta

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meta }
    end
  end

  # GET /metas/new GET /metas/new.xml
  def new
    @meta = Meta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meta }
    end
  end

  # GET /metas/1/edit
  def edit
    @meta = @page.meta
  end

  # POST /metas POST /metas.xml
  def create
    @meta = Meta.new(params[:meta])
    
    respond_to do |format|
      if @meta.save
        flash[:notice] = 'Metainformación añadida correctamente.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @meta, :status => :created, :location => @meta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /metas/1 PUT /metas/1.xml
  def update
    @meta = @page.meta

    respond_to do |format|
      if @meta.update_attributes(params[:meta])
        flash[:notice] = 'Metadatos guardados'
        format.html { redirect_to([:admin, @page, @meta]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /metas/1 DELETE /metas/1.xml
  def destroy
    @meta = Meta.find(params[:id])
    @meta.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.xml  { head :ok }
    end
  end
  
end
