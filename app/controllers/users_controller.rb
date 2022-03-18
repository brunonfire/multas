class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_userid, only: :enable_disable
  before_action :set_company, only: [:new, :create, :edit, :update]

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: update_msg  }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: destroy_msg }
      format.json { head :no_content }
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def show
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    @user.company = current_company
    @user.created_by = current_user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: create_msg }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def enable_disable
    status = "enabled" == @user.status ? "disabled" : "enabled"
    @user.status = status
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: enable_disable_msg(status) }
        format.json { render :show, status: :created, location: @user }
        format.js { render layout: false, locals: { msg: enable_disable_msg(status) } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { render layout: false }
      end
    end
  end
  private

  def set_company
    @companies = Company.where(company_type: :main)
    @branches = Company.where(company_type: :branch)
    @Companies = Company.all
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_userid
    @user = User.find(params[:user_id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :status, :user_type, :company_id, :created_by)
  end

end
