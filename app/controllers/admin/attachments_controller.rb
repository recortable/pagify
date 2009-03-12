class Admin::AttachmentsController < Admin::AdminController

  # GET /attachments GET /attachments.xml
  def index
    @attachments = Attachment.paginate :page => params[:page], :per_page => 10,
      :conditions => ['parent_id IS NULL'], :order => 'updated_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @attachments }
    end
  end

  # GET /attachments/1 GET /attachments/1.xml
  def show
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/new GET /attachments/new.xml
  def new
    @attachment = Attachment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @attachment }
    end
  end

  # GET /attachments/1/edit
  def edit
    @attachment = Attachment.find(params[:id])
  end

  # POST /attachments POST /attachments.xml
  def create
    # FIXME: attachment_fu
    @attachment = Attachment.new(params[:attachment])
    @attachment.page_id = params[:attachment][:page_id]

    respond_to do |format|
      if @attachment.save
        flash[:notice] = 'Archivo subido.'
        format.html { redirect_to :back }
        format.xml  { render :xml => @attachment, :status => :created, :location => @attachment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /attachments/1 PUT /attachments/1.xml
  def update
    @attachment = Attachment.find(params[:id])

    respond_to do |format|
      if @attachment.update_attributes(params[:attachment])
        flash[:notice] = 'Fichero añadido.'
        format.html { redirect_to :back }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @attachment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def relabel
    attachment = Attachment.find(params[:id])
    attachment.update_attribute('label', params[:label])
    flash[:notice] = 'Se cambió la etiqueta al fichero.'
    redirect_to :back
  end

  # DELETE /attachments/1 DELETE /attachments/1.xml
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to :back}
      format.xml  { head :ok }
    end
  end
end
