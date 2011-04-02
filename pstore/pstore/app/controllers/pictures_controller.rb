class PicturesController < ApplicationController

  # GET /pictures
  # GET /pictures.xml
  def index
    base = "http://192.168.1.99:3000/"

    @pictures = Picture.all
    @pictures.each do |picture|
      picture.image_uri = base + "pictures/blob/" + picture.id.to_s
      # don't show the 64 encoded stuff, no reason.
      picture.image = ''
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pictures }
      format.json  { render :json => @pictures }
    end
  end

  # GET /pictures/1
  # GET /pictures/1.xml
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @picture }
      format.json  { render :json => @pictures }
    end
  end

  # GET /pictures/new
  # GET /pictures/new.xml
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @picture }
      format.json  { render :json => @pictures }
    end
  end

  # GET /pictures/1/edit
  def edit
    @picture = Picture.find(params[:id])
    format.json  { render :json => @pictures }
  end

  # POST /pictures
  # POST /pictures.xml
  def create
    @picture = Picture.new(params[:picture])
    respond_to do |format|
      if @picture.save
        format.html { redirect_to(@picture, :notice => 'Picture was successfully created.') }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
        format.json  { render :json => @picture, :status => :created, :location => @picture }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
        format.json  { render :json => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pictures/1
  # PUT /pictures/1.xml
  def update
    @picture = Picture.find(params[:id])

    respond_to do |format|
      if @picture.update_attributes(params[:picture])
        format.html { redirect_to(@picture, :notice => 'Picture was successfully updated.') }
        format.xml  { head :ok }
        format.json  { render :json, :status => :created }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
        format.json  { render :json => @picture.errors, :status => :created }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.xml
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy

    respond_to do |format|
      format.html { redirect_to(pictures_url) }
      format.xml  { head :ok }
      format.json  { render :json => { "status" => "ok" } }
    end
  end

  # GET /pictures/blob/1
  def blob
    send_data(Base64.decode64(Picture.find( params[:id] ).image), :type=>'image/png', :disposition => 'inline')
  end


end
