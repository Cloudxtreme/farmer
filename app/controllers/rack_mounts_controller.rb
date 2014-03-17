class RackMountsController < ApplicationController
  before_action :set_rack_mount, only: [:show, :edit, :update, :destroy]

  # GET /rack_mounts
  # GET /rack_mounts.json
  def index
    @rack_mounts = RackMount.order( :name )
  end

  # GET /rack_mounts/1
  # GET /rack_mounts/1.json
  def show
  end

  # GET /rack_mounts/new
  def new
    @rack_mount = RackMount.new
    @locations  = Location.order( :name )
  end

  # GET /rack_mounts/1/edit
  def edit
    @locations  = Location.order( :name )
  end

  # POST /rack_mounts
  # POST /rack_mounts.json
  def create
    @rack_mount = RackMount.new( rack_mount_params )

    respond_to do |format|
      if update_indexes( @rack_mount ) and @rack_mount.save
        format.html { redirect_to @rack_mount, notice: 'Rack mount was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rack_mount }
      else
        format.html { render action: 'new' }
        format.json { render json: @rack_mount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rack_mounts/1
  # PATCH/PUT /rack_mounts/1.json
  def update
    @rack_mount.update( rack_mount_params )

    respond_to do |format|
      if update_indexes( @rack_mount ) and @rack_mount.save
        format.html { redirect_to @rack_mount, notice: 'Rack mount was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rack_mount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rack_mounts/1
  # DELETE /rack_mounts/1.json
  def destroy
    @rack_mount.destroy
    respond_to do |format|
      format.html { redirect_to rack_mounts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rack_mount
      @rack_mount = RackMount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rack_mount_params
      params.require(:rack_mount).permit( :name, :location_id, :position )
    end


    def update_indexes rack_mount
      rack_mount.generate_index!

      rack_mount.servers.each do |server|

        server.vms.each do |vm|
          vm.generate_index!
          return false unless vm.save
        end

        server.generate_index!
        return false unless server.save
      end

      rack_mount.location.generate_index!
      return false unless rack_mount.location.save

      return true
    end
end
