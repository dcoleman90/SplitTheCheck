class HistoriesController < ApplicationController
  before_action :set_history, 
  	only: [:show, :edit, :update, :destroy]

  # GET /histories
  # GET /histories.json
  def index
    if session[:is_admin]
      @histories = History.order(created_at: :desc)
    else
      redirect_to restaurants_url
    end
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
  	if !session[:is_admin]
  	  redirect_to restaurants_url
  	end
  end

  # GET /histories/new
  # Removed to avoid manipulation of our history log. 

  # GET /histories/1/edit
  # Removed to avoid manipulation of our history log. 

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
  
  # GET /up_vote
  def up_vote
    history = History.new
    history.restaurant_id  = session[:restaurant_id]
    history.user_id        = session[:user_id]
    history.up_votes_added = 1
	
	old_history = History.where(
		restaurant_id: history.restaurant_id).last
	
	session[:restaurant_id] = nil
	
	if !old_history.nil?
	  history.up_votes_total = 
	  	old_history.up_votes_total + 1
	  history.down_votes_total = 
	  	old_history.down_votes_total
	else
	  history.up_votes_total = 1;
	end
	
    respond_to do |format|
      begin
        if history.save
          format.html { redirect_to restaurant_url(history.restaurant_id), 
        	notice: 'Your vote has been recorded.' }
          format.json { render :show, status: :created, 
        	location: history }
        else
          format.html { redirect_to restaurants_url,
            notice: 'Unable to save vote. Try again.' }
          format.json { render json: history.errors, 
        	status: :unprocessable_entity }
        end
      rescue
      	  format.html { redirect_to restaurants_url, 
      	    notice: "May not vote twice for 
      	    #{history.restaurant.name}."}
      end
    end
  end
  
  # GET /down_vote
  def down_vote
    history = History.new
    history.restaurant_id    = session[:restaurant_id]
    history.user_id 	     = session[:user_id]
    history.down_votes_added = 1
	
	old_history = History.where(
		restaurant_id: history.restaurant_id).last
	
	session[:restaurant_id] = nil
	
	if !old_history.nil?
	  history.down_votes_total = 
	  	old_history.down_votes_total + 1
	  history.up_votes_total = 
	  	old_history.up_votes_total
	else
	  history.down_votes_total = 1;
	end
	
    respond_to do |format|
      begin
        if history.save
          format.html { redirect_to restaurant_url(history.restaurant_id), 
        	notice: 'Your vote has been recorded.' }
          format.json { render :show, status: :created, 
        	location: history }
        else
          format.html { redirect_to users_url,
            notice: 'Unable to save vote. Try again.' }
          format.json { render json: history.errors, 
        	status: :unprocessable_entity }
        end
      rescue
      	  format.html { redirect_to histories_url, 
      	    notice: "May not vote twice for 
      	    #{history.restaurant.name}."}
      end
    end
  end

  # PATCH/PUT /histories/1
  # PATCH/PUT /histories/1.json
  # Removed to avoid manipulation of our history log. 

  # DELETE /histories/1
  # DELETE /histories/1.json
  # Removed to avoid manipulation of our history log. 

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
