class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]
  before_action :set_cars , only: %i[new edit]
  before_action :set_car_id , only: :enable_disable


  # GET /cars or /cars.json
  def index
    @cars = Car.paginate(page: params[:page], per_page: 2)

  end

  # GET /cars/1 or /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)
    @car.company = current_company
    @car.created_by = current_user


    respond_to do |format|
      if @car.save
        format.html { redirect_to car_url(@car), notice: create_msg }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_to new_car_url, alert: I18n.t("errors.messages.all_fields")
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to car_url(@car), notice: update_msg }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_to edit_car_url, alert: I18n.t("errors.messages.all_fields")
  end

  def enable_disable
    status = "enabled" == @car.status ? "disabled" : "enabled"
    @car.status = status
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: enable_disable_msg(status) }
        format.json { render :show, status: :created, location: @car }
        format.js { render layout: false, locals: { msg: enable_disable_msg(status) } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
        format.js { render layout: false }
      end
    end
  end


  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy

    respond_to do |format|
      format.html { redirect_to cars_url, notice: destroy_msg }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    def set_cars
      @car_models = CarModel.all
      @cars = Car.all
    end

  def set_car_id
    @car = Car.find(params[:car_id])
  end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:year, :license_plate, :status, :car_model_id)
    end
end
