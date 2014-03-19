class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :edit, :update, :destroy]
  before_action :set_periods, only: [:index, :all, :new, :create]
  before_filter :authenticate_user!

  # GET /periods
  # GET /periods.json
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @dados = Period.get_tests_events_init_times(@periods, @date)
    gon.subjects = @dados["subjects"].map &:attributes
  end

  def all
  end
  # GET /periods/1
  # GET /periods/1.json
  def show
  end

  # GET /periods/new
  def new
    @period = @periods.new
  end

  # GET /periods/1/edit
  def edit
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = @periods.new(period_params)
    @period = Period.check_current_period(@period)

    if  @period.current_period && current_user.periods.where(current_period: true).count > 0
      render action: "new"
    else
      if @period.save
        redirect_to @period, notice: 'Period was successfully created.'
      end
    end

  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      @period = Period.check_current_period(@period)

      if @period.update(period_params)
        format.html { redirect_to @period, notice: 'Period was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = current_user.periods.find(params[:id])
    end

    def set_periods
      @periods = current_user.periods
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:init_date, :final_date, :number)
    end
end
