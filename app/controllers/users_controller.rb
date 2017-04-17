class UsersController < ApplicationController
  skip_before_action :authorize, only: [:create, :new]
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    if !session[:is_admin]
      redirect_to restaurants_url
    else
      @users = User.order(:name)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if !session[:is_admin]
      redirect_to restaurants_url
<<<<<<< HEAD
    end 
=======
    end
>>>>>>> parent of 09297c9... Comments table made along with scaffolding.
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if !session[:is_admin]
      redirect_to restaurants_url
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if session[:is_admin] && @user.save
      	format.html { redirect_to admin_url, 
        notice: "User #{@user.name} was successfully created." }
        format.json { render :index, status: :created }
      elsif @user.save
        session[:user_id] = @user.id
        format.html { redirect_to restaurants_url, 
        notice: "User #{@user.name} was successfully created." }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @user.errors,
        status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_url, 
        notice: "User #{@user.name} was successfully updated." }
        format.json { render :show, status: :ok, 
        location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, 
        status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  # Removed functionality in order keep keep referential
  # integrity within our DB histories table

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
