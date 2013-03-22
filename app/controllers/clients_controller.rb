class ClientsController < ApplicationController
  before_filter :authenticate_user!
    def index
      
    if params[:client_id]
    @clients = Client.filter_by_client(params[:client_id]).paginate(:page => params[:page], :per_page => 10)
    else
    @clients = Client.all
    end
    # @clients = Client.all
    respond_to do |format|
      format.html
      format.json {render :json => @clients }
    end
  end

  def show
    @contact_info = ContactInfo.new
    @client = Client.find(params[:id])
    respond_to do |format|
      format.html
      
    end
  end

  def new
    @client = Client.new
    respond_to do |format|
      format.html
      
    end
  end

  def create
    @client = Client.new(params[:client])
    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, :notice => 'Client Successfully created'}
        format.json {render :json => @client, :status => :created, :location =>@client }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, :notice => 'Client successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.delete

    respond_to do |format|
      format.html { redirect_to clients_path }
      format.json { head :ok }
    end
  end
end
