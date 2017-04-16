class RestaurantsController < ApplicationController
  skip_before_action :authorize, only: [:index, :show]  
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy, :up_vote, :down_vote]

  # GET /restaurants
  # GET /restaurants.json
  def index
    if !params[:search].blank? 
  	  @restaurants = 
  	  	Restaurant.search(params[:search]).order(:name)
  	else
  	  @restaurants = Restaurant.order(:name)
  	end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/1/edit
  def edit
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, 
        	notice: 'Restaurant was successfully created.' }
        format.json { render :show, status: :created, 
        	location: @restaurant }
      else
        format.html { render :new }
        format.json { render json: @restaurant.errors,
        	 status: :unprocessable_entity }
      end
    end
  end
  
  # GET /restaurants/1/up_vote
  def up_vote
	session[:restaurant_id] = @restaurant.id
	
	redirect_to up_vote_path
  end
  
  # GET /restaurants/1/down_vote
  def down_vote
	session[:restaurant_id] = @restaurant.id
	
	redirect_to down_vote_path
  end


  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, 
        	notice: 'Restaurant was successfully updated.' }
        format.json { render :show, status: :ok, 
        	location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors,
        	 status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  # Removed functionality in order keep keep referential
  # integrity within our DB histories table

  # ----------------------------------------------------
  # Private helpers ------------------------------------
  # ----------------------------------------------------
  private
    # Use callbacks to share common setup or constraints
    # between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, 
    # only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :city, :state, :zip)
    end
end
