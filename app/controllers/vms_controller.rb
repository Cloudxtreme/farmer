class VmsController < ApplicationController
  before_action :set_vm, only: [:show, :edit, :update, :destroy]

  # GET /vms
  # GET /vms.json
  def index
    @vms = Vm.order( :name )
  end

  # GET /vms/1
  # GET /vms/1.json
  def show
  end

  # GET /vms/new
  def new
    @vm      = Vm.new
    @servers = Server.order( :name )
  end

  # GET /vms/1/edit
  def edit
    @servers = Server.order( :name )
  end

  # POST /vms
  # POST /vms.json
  def create
    @vm = Vm.new( vm_params )

    respond_to do |format|
      if update_indexes( @vm ) and @vm.save
        format.html { redirect_to @vm, notice: 'Vm was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vm }
      else
        format.html { render action: 'new' }
        format.json { render json: @vm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vms/1
  # PATCH/PUT /vms/1.json
  def update
    @vm.update( vm_params )

    respond_to do |format|
      if update_indexes( @vm ) and @vm.save
        format.html { redirect_to @vm, notice: 'Vm was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vms/1
  # DELETE /vms/1.json
  def destroy
    server = @vm.server

    @vm.destroy

    server.rack_mount.location.generate_index!

    respond_to do |format|
      format.html { redirect_to vms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vm
      @vm = Vm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vm_params
      params.require(:vm).permit( :name, :domain, :ip, :ram, :hd, :server_id, :position )
    end


    def update_indexes vm
      vm.generate_index!

      vm.server.generate_index!
      return false unless vm.server.save

      vm.server.rack_mount.generate_index!
      return false unless vm.server.rack_mount.save

      vm.server.rack_mount.location.generate_index!
      return false unless vm.server.rack_mount.location.save

      return true
    end
end
