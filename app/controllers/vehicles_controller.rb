class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]

  def index
    @filters       = OpenStruct.new(params[:search])
    @vehicles = Vehicle.filter_records(params)#.page params[:page]
  end

  def show
  end

  def new
    @vehicle = Vehicle.new
  end

  def comment
    @vehicle = Vehicle.find(params[:id].to_i)
    @vehicle.comments.create(:title => params[:title], :comment => params[:comment], :user_id => params[:user_id])
    redirect_to vehicle_path(@vehicle)
  end

  def edit
  end

  def add_favorite
    @vehicle = Favorite.find_by_vehicle_id(params[:id])
    if @vehicle.present?
      @vehicle.update_attributes(:active => (!@vehicle.active))
    else
     @vehicle = Favorite.create(:active=>true,:user_id => current_user.id, :vehicle_id => params[:id])
    end
    respond_to do |format|
    format.json { render json: @vehicle }
    end

  end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    respond_to do |format|
      if @vehicle.save
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vehicle }
      else
        format.html { render action: 'new' }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vehicle.update(vehicle_params)
        format.html { redirect_to @vehicle, notice: 'Vehicle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url }
      format.json { head :no_content }
    end
  end

  private
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_params
      params.require(:vehicle).permit(:title, :vin, :price,:avatar,:note, :description, :active, :status, :category_id, :vehicle_model)
    end
end
