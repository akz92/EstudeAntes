class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  before_filter do
    @subject = get_subject(params[:subject_id])
    @period = get_period(@subject.period_id)
  end

  # GET /events
  # GET /events.json
  # def index
  #   @events = @subject.events.all
  # end

  # GET /events/1
  # GET /events/1.json
  # def show
  # end

  # GET /events/new
  def new
    @event = @subject.events.new
  end

  # GET /events/1/edit
  def edit
    @event.weekday = @event.start_date.wday
  end

  # POST /events
  # POST /events.json
  def create
    @event = @subject.events.by_date(event_params, @period, @subject)

    flash[:success] = 'Evento criado com sucesso.' if @event.save
    respond_with(@event, location: period_subject_path(@period, @subject))
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    flash[:notice] = 'Evento atualizado com sucesso.' if @event.by_date(event_params, @period, @subject)
    respond_with(@event, location: period_subject_path(@period, @subject))
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    flash[:notice] = 'Evento removido com sucesso.' if @event.destroy
    respond_with(@event, location: period_subject_path(@period, @subject))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @period = get_period(params[:period_id])
      @subject = get_subject(params[:subject_id])
      @event = @subject.events.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:start_date, :every, :end_date, :start_time, :end_time, :title, :weekday)
    end
end
