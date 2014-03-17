class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.order( :position )
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new( location_params )

    respond_to do |format|
      if update_indexes( @location ) and @location.save
        format.html { redirect_to locations_path, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @location.update( location_params )

    respond_to do |format|
      if update_indexes( @location ) and @location.save
        format.html { redirect_to locations_path, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit( :name, :position )
    end

    
    def update_indexes location
      location.generate_index!

      location.rack_mounts.each do |rack_mount|

        rack_mount.servers.each do |server|

          server.vms.each do |vm|
            vm.generate_index!
            return false unless vm.save
          end

          server.generate_index!
          return false unless server.save
        end

        rack_mount.generate_index!
        return false unless rack_mount.save
      end

      return true
    end
end
