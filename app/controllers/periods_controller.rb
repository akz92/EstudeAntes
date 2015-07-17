class PeriodsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_period, only: [:show, :edit, :update, :destroy]
  before_action :set_current_period, only: [:index, :new, :edit]
  before_action :set_other_periods, only: [:all, :index]
  before_action :set_periods, only: [:new, :create]

  # GET /periods
  # GET /periods.json
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today.beginning_of_week
    @dados = Period.get_tests_events_init_times(@current_period, @date, @other_periods)
    gon.subjects = @dados["subjects"].map &:attributes
  end

  def all
    Period.get_periods_and_means(@other_periods)
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
		    redirect_to root_path, notice: 'Periodo criado com sucesso'
	    end
    end

  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    @period = Period.check_current_period(@period)

    if @period.update(period_params)
      if @period.current_period
        redirect_to root_path, notice: 'Periodo atualizado com sucesso'
      else
        redirect_to period_subjects_path(@period), notice: 'Periodo atualizado com sucesso'
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy

    if @period.current_period
      redirect_to periods_url, notice: 'Periodo removido com sucesso'
    else
      redirect_to periods_all_path, notice: 'Periodo removido com sucesso'
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

    def set_current_period
      @current_period = []
      @dados_periodo = {"period_number" => []}
      periods = current_user.periods
      periods.each do |period|
        if period.current_period
          @current_period << period
	  @dados_periodo["period_number"] = period.number
        end
      end
    end

    def set_other_periods
      @other_periods = []
      periods = current_user.periods
      periods.each do |period|
        unless period.current_period
          @other_periods << period
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:init_date, :final_date, :number)
    end
end
