class PeriodsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_period, only: [:show, :edit, :update, :destroy]
  before_action :set_current_period, only: [:index, :new, :edit, :fullcalendar_events]
  #before_action :set_other_periods, only: [:all, :index]
  before_action :set_periods, only: [:new, :create, :index]
  respond_to :html, :json

  # GET /periods
  # GET /periods.json
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today.beginning_of_week
    first_and_last_hour = Period.get_calendar_hours(@current_period)
    @period = @periods.new
    gon.subjects = @current_period.subjects.map &:attributes
    gon.mintime = first_and_last_hour.first
    gon.maxtime = first_and_last_hour.last
  end

  def fullcalendar_events
    events = Period.get_events(@current_period)
    render json: events
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
      flash[:notice] = "Ja existe um periodo vigente."
    else
      flash[:notice] = "Periodo criado com sucesso." if  @period.save
      respond_with(@period) do |format|
        format.html { redirect_to root_path }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    @period = Period.check_current_period(@period)

    flash[:notice] = "Periodo atualizado com sucesso." if @period.update(period_params)
    respond_with(@period) do |format|
      if @period.current_period
        format.html { redirect_to root_path }
      else
        format.html { redirect_to period_subjects_path(@period) }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    flash[:notice] = "Periodo removido com sucesso." if @period.destroy
    respond_with(@period)
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
      @other_periods = []
      @dados_periodo = {"period_number" => []}
      periods = current_user.periods
      periods.each do |period|
        if period.current_period
          @current_period = period
	  @dados_periodo["period_number"] = period.number
        else
          @other_periods<< period
        end
      end
    end

    #def set_other_periods
    #  @other_periods = []
    #  periods = current_user.periods
    #  periods.each do |period|
    #    unless period.current_period
    #      @other_periods << period
    #    end
    #  end
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:init_date, :final_date, :number)
    end
end
