class FinesController < ApplicationController
  before_action :set_fine, only: %i[ show edit update destroy ]
  before_action :get_users, only: [:edit, :new, :create]
  before_action :get_branches, only: [:edit, :new, :create]
  before_action :set_fine_status, only: :identified_unidentified
  before_action :get_states, only: [:edit, :new, :create]
  before_action :get_fine_points, only: [:edit, :new, :create]


  # GET /fines or /fines.json
  def index
    @fines = Fine.paginate(page: params[:page], per_page: 2)
  end

  # GET /fines/1 or /fines/1.json
  def show
  end

  # GET /fines/new
  def new
    @fine = Fine.new
  end

  # GET /fines/1/edit
  def edit
  end

  # POST /fines or /fines.json
  def create
    @fine = Fine.new(fine_params)
    @fine.company = current_company
    @fine.created_by = current_user

    respond_to do |format|
      if @fine.save
        format.html { redirect_to fine_url(@fine), notice: create_msg }
        format.json { render :show, status: :created, location: @fine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fines/1 or /fines/1.json
  def update
    respond_to do |format|
      if @fine.update(fine_params)
        format.html { redirect_to fine_url(@fine), notice: update_msg }
        format.json { render :show, status: :ok, location: @fine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @fine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fines/1 or /fines/1.json
  def destroy
    @fine.destroy

    respond_to do |format|
      format.html { redirect_to fines_url, notice: destroy_msg }
      format.json { head :no_content }
    end
  end

  def identified_unidentified
    status = "identified" == @fine.fine_status ? "unidentified" : "identified"
    @fine.fine_status = status
    respond_to do |format|
      if @fine.save
        format.html { redirect_to @fine, notice: enable_disable_msg(status) }
        format.json { render :show, status: :created, location: @fine }
        format.js { render layout: false, locals: { msg: enable_disable_msg(status) } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @fine.errors, status: :unprocessable_entity }
        format.js { render layout: false, locals: { msg: @fine.errors.full_messages } }
      end
    end
  end


  private

  def get_users
    @users = User.all
  end

  def get_branches
    # @branches = Company.where(:company_type => :branch )  #vai aplicar somente para as filiais
    @branches = Company.all
  end

  def get_states
    @states = State.all
  end

  def get_fine_points
    @fine_points = FinePoint.all
  end

  def set_fine_status
    @fine = Fine.find(params[:fine_id])
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_fine
      @fine = Fine.find(params[:id])

    end

    # Only allow a list of trusted parameters through.
    def fine_params
      params.require(:fine).permit(:user_id, :fine_date, :fine_status, :fine_number, :branch_id, :detran_id, :fine_point_id)
    end
end
