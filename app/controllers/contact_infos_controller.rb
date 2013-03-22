class ContactInfosController < ApplicationController
  before_filter :authenticate_user!
  def index
    @contact_infos = ContactInfo.all
    respond_to do |format|
      format.html
      format.json {render :json => @contact_infos }
    end
  end

  def show
    @client = Client.find(params[:id])
    @contact_info = @client.contact_infos
    respond_to do |format|
      format.html
      format.json {render :json => @contact_info }
    end
  end

  def new
    @contact_info = ContactInfo.new
    respond_to do |format|
      format.html
      
    end
  end

  def create
    # finds the client by id
    @client = Client.find(params[:client_id])
    # loop through each contact info in the params
    params[:contact_info].each do |info|
    # for each contact info, create a new record for given client
      contact_info = @client.contact_infos.new(info)
      # save record to database and store result
      if !contact_info.save
        # if the record does not save, render and exit
        redirect_to @client, :notice => contact_info.errors.full_messages.join("\n")
      return
      end
    end
    # all contact infos in params are saved, redirect to client show page
    redirect_to @client, :notice => 'Contact Information successfully updated.'
  end

  def edit
    @contact_info = ContactInfo.find(params[:id])
  end

  def update
    @contact_info = ContactInfo.find(params[:id])
    respond_to do |format|
      if @contact_info.update_attributes(params[:contact_info])
        format.html { redirect_to @contact_info, :notice => 'Contact Information successfully updated.' }
      else
        format.html { render :action => "edit" }
      
      end
    end
  end

  def destroy
    @contact_info = ContactInfo.find(params[:id])
    @client = @contact_info.client
    @contact_info.destroy
    respond_to do |format|
      format.html { redirect_to @client }
      
    end
  end
end
