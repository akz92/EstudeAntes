class PeriodsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_period, only: [:show, :edit, :update, :destroy]
  before_action :set_current_period, only: [:index, :fullcalendar_events]
  before_action :set_periods, only: [:new, :create, :index]
  respond_to :html, :json

  # GET /periods
  # GET /periods.json
  def index
    if @period
      gon.calendar_hours = @period.calendar_hours
      gon.subjects = @period.subjects.map &:attributes
    end
  end

  def fullcalendar_events
    events = @period.get_events
    render json: events
  end

  def all
    #Period.get_periods_and_means(@other_periods)
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
    @period.is_current?
    if  @period.save
      flash[:success] = 'Periodo criado com sucesso.'
    else
      flash[:error] = 'O periodo nao pode ser criado.' 
    end
    respond_with(@period) do |format|
      format.html { redirect_to root_path }
    end

    #if  @period.is_current && current_user.periods.where(is_current: true).count > 0
    #  render action: 'new'
    #  flash[:notice] = 'Ja existe um periodo vigente.'
    #else
    #  flash[:notice] = 'Periodo criado com sucesso.' if  @period.save
    #  respond_with(@period) do |format|
    #    format.html { redirect_to root_path }
    #  end
    #end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    @period = Period.check_current_period(@period)

    flash[:notice] = 'Periodo atualizado com sucesso.' if @period.update(period_params)
    respond_with(@period) do |format|
      if @period.is_current
        format.html { redirect_to root_path }
      else
        format.html { redirect_to period_subjects_path(@period) }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    flash[:notice] = 'Periodo removido com sucesso.' if @period.destroy
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
      @other_periods = []
      periods = current_user.periods
      periods.each do |period|
        if period.is_current
          @period = period
        else
          @other_periods << period
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:start_date, :end_date, :number)
    end
end
