class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :get_period_number, only: [:new, :edit]
  respond_to :json
  before_filter do
    @period = Period.find(params[:period_id])
    @subject = @period.subjects.find(params[:subject_id])
  end

  # GET /events
  # GET /events.json
  def index
    @events = @subject.events.all
  end

  def get_events
    @events = @subject.events.all
    fullcalendar_events = []
    @events.each do |event|
      fullcalendar_events << {id: event.id, title: @subject.name, start: event.init_time, end: event.final_time}
    end
    render text: fullcalendar_events.to_json
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = @subject.events.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = @subject.events.new(event_params)
    @event.subject_name = @subject.name

    respond_to do |format|
      if @event.save
        format.html { redirect_to period_subject_path(@period, @subject), notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to period_subject_path(@period, @subject), notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to period_subject_path(@period, @subject) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @period = Period.find(params[:period_id])
      @subject = @period.subjects.find(params[:subject_id])
      @event = @subject.events.find(params[:id])
    end

    def get_period_number
      @period = Period.find(params[:period_id])
      @dados_periodo = Event.period_number(@period)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:weekday, :init_time, :final_time, :recurrent)
    end
end
