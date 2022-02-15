class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]
  before_action :set_city, only: %i[ new edit ]

  # GET /companies or /companies.json
  def index
    @companies = Company.paginate(page: params[:page], per_page: 2)
  end

  # GET /companies/1 or /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)
    @company.company = current_company
    @company.created_by = current_user


    respond_to do |format|
      if @company.save
        format.html { redirect_to company_url(@company), notice: create_msg }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_to new_company_url, alert: I18n.t("errors.messages.all_fields")
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to company_url(@company), notice: update_msg }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  rescue
    redirect_to edit_company_url, alert: I18n.t("errors.messages.all_fields")
  end

  def set_city
    state = State.select(:id).where(acronym: ["SC", "PR"])
    @cities = City.where(state_id: state)
    @states = State.where(acronym: ["SC","PR"])
  end


  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url, notice: destroy_msg }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :company_type, :cnpj, :phone, :address, :number, :zipcode, :district, :city_id)
    end
end
