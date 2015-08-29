class PeriodsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_current_period, except:[:create]
  before_action :set_other_periods, only: [:all]
  before_action :set_periods, only: [:new, :create, :index, :destroy]
  respond_to :html, :json

  # GET /periods
  # GET /periods.json
  def index
    if @period
      gon.calendar_hours = @period.calendar_hours
      gon.subjects = @period.subjects.map &:attributes
    end
  end

  # Provides a JSON containing every event's dates to be rendered by FullCalendar
  def fullcalendar_events
    events = @period.get_events
    render json: events
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
      format.html { redirect_to choose_redirect_path(@period) }
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    @period.is_current?

    flash[:success] = 'Periodo atualizado com sucesso.' if @period.update(period_params)
    respond_with(@period, location: choose_redirect_path(@period))
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    period = @periods.find_by(id: params[:id])
    flash[:success] = 'Periodo removido com sucesso.' if period.destroy
    respond_with(period)
  end

  private
    def set_periods
      @periods = current_user.periods
    end

    def set_current_period
      @period = current_user.periods.find_by(is_current: true)
    end

    def set_other_periods
      @other_periods = current_user.periods.reject { |x| x.is_current }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:start_date, :end_date, :number)
    end
end
