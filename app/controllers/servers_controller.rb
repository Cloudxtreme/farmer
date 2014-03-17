class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :destroy]

  # GET /servers
  # GET /servers.json
  def index
    @servers = Server.order( :name )
  end

  # GET /servers/1
  # GET /servers/1.json
  def show
  end

  # GET /servers/new
  def new
    @server      = Server.new
    @racks       = RackMount.order( :name )
    @categories  = Category.order( :name )
  end

  # GET /servers/1/edit
  def edit
    @racks       = RackMount.order( :name )
    @categories  = Category.order( :name )
  end

  # POST /servers
  # POST /servers.json
  def create
    @server = Server.new( server_params )

    respond_to do |format|
      if update_indexes( @server ) and @server.save
        format.html { redirect_to @server, notice: 'Server was successfully created.' }
        format.json { render action: 'show', status: :created, location: @server }
      else
        format.html { render action: 'new' }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /servers/1
  # PATCH/PUT /servers/1.json
  def update
    @server.update( server_params )

    respond_to do |format|
      if update_indexes( @server ) and @server.save
        format.html { redirect_to @server, notice: 'Server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /servers/1
  # DELETE /servers/1.json
  def destroy
    rack_mount = @server.rack_mount

    @server.destroy

    rack_mount.location.generate_index!

    respond_to do |format|
      format.html { redirect_to servers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def server_params
      params.require(:server).permit( :name, :domain, :model, :ip, :ram, :hd, :rack_mount_id, :position, :category_id )
    end


    def update_indexes server
      server.generate_index!

      server.vms.each do |vm|
        vm.generate_index!
        return false unless vm.save
      end

      server.rack_mount.generate_index!
      return false unless server.rack_mount.save

      server.rack_mount.location.generate_index!
      return false unless server.rack_mount.location.save

      return true
    end
end
