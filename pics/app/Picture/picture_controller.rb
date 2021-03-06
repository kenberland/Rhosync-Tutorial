require 'rho/rhocontroller'
require 'helpers/browser_helper'

class PictureController < Rho::RhoController
  include BrowserHelper

  #GET /Picture
  def index
    @pictures = Picture.find(:all)
    render
  end

  # GET /Picture/{1}
  def show
    @picture = Picture.find(@params['id'])
    if @picture
      render :action => :show
    else
      redirect :action => :index
    end
  end

  # GET /Picture/new
  def new
    Camera::take_picture(url_for :action => :camera_callback)
    @picture = Picture.new
    render :action => :new
  end

  # GET /Picture/{1}/edit
  def edit
    @picture = Picture.find(@params['id'])
    if @picture
      render :action => :edit
    else
      redirect :action => :index
    end
  end

  # POST /Picture/create
  def create   
    redirect :action => :index
  end

  # POST /Picture/{1}/update
  def update
    @picture = Picture.find(@params['id'])
    @picture.update_attributes(@params['picture']) if @picture
    SyncEngine.dosync
    redirect :action => :index
  end

  # POST /Picture/{1}/delete
  def delete
    @picture = Picture.find(@params['id'])
    @picture.destroy if @picture
    redirect :action => :index
  end
  
  def camera_callback
    if @params['status'] == 'ok'
      #create image record in the DB
      picture = Picture.new({'image_uri'=>@params['image_uri']})
      picture.save
      tempObj = picture.instance_variable_get("@vars")
      WebView.navigate( url_for :action => :edit, :id => tempObj[:object] )
      return ""
    end
    if @params['status'] == 'error'
      puts "Error with camera, perhaps camera is not enabled in build.yml."
      unless @params['message'].nil? 
        puts @params['message']
      end    
    end
    WebView.navigate( url_for :action => :index )
    ""
  end
end
