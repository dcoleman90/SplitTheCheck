class HistoriesController < ApplicationController
  before_action :set_history, 
  	only: [:show, :edit, :update, :destroy]

  # GET /histories
  # GET /histories.json
  def index
    @histories = History.all
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  end

  # GET /histories/new
  def new
    @history = History.new
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(history_params)

    respond_to do |format|
      begin
        if @history.save
          format.html { redirect_to @history, 
        	notice: 'History was successfully created.' }
          format.json { render :show, status: :created, 
        	location: @history }
        else
          format.html { render :new }
          format.json { render json: @history.errors, 
        	status: :unprocessable_entity }
        end
      rescue
      	  format.html { redirect_to @history, 
      	    notice: 'May not add duplicate votes.'}
      end
    end
  end
  
  # PATCH /restaurants/1/up_vote
  def up_vote
    @history = History.new
    @history.restaurant_id = session[:restaurant_id]
    @history.user_id = session[:user_id]
    @history.up_votes_added = 1
	old_history = History.where(restaurant_id: @history.restaurant_id).last
	session[:restaurant_id] = nil
	if !old_history.nil?
	  @history.up_votes_total = old_history.up_votes_total + 1
	else
	  @history.up_votes_total = 1;
	end
	
    respond_to do |format|
      begin
        if @history.save
          format.html { redirect_to restaurants_url, 
        	notice: 'Your vote has been recorded.' }
          format.json { render :show, status: :created, 
        	location: @history }
        else
          format.html { redirect_to restaurants_url,
            notice: 'Unable to save vote. Try again.' }
          format.json { render json: @history.errors, 
        	status: :unprocessable_entity }
        end
      rescue
      	  format.html { redirect_to restaurants_url, 
      	    notice: 'May not add duplicate votes.'}
      end
    end
  end
  
  # PATCH /restaurants/1/down_vote
  def down_vote
	respond_to do |format|
      if @restaurant.update(down_votes:
      	 	@restaurant.down_votes + 1)

        format.html { redirect_to @restaurant, 
        	notice: 'Down vote recorded.' }
        format.json { render :show, status: :ok, 
        	location: @restaurant }
      else
        format.html { render :edit }
        format.json { render json: @restaurant.errors,
        	 status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  def update
    respond_to do |format|
      begin
        if @history.update(history_params)
          format.html { redirect_to @history, 
        	notice: 'History was successfully updated.' }
          format.json { render :show, status: :ok, 
        	location: @history }
        else
          format.html { render :edit }
          format.json { render json: @history.errors, 
        	status: :unprocessable_entity }
        end
       rescue
      	  format.html { redirect_to @history, 
      	    notice: 'May not add duplicate votes.'}
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history.destroy
    respond_to do |format|
      format.html { redirect_to histories_url, 
      	notice: 'History was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints
    # between actions.
    def set_history
      @history = History.find(params[:id])
    end

    # Never trust parameters from the scary internet, 
    # only allow the white list through.
    def history_params
      params.require(:history).permit(:restaurant_id, :user_id, :up_votes_added, :down_votes_added, :up_votes_total, :down_votes_total)
    end
end
