class EventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  before_filter do
    @subject = get_subject(params[:subject_id])
    @period = get_period(@subject.period_id)
  end

  # POST /events
  # POST /events.json
  def create
    @event = @subject.events.new(event_params)
    @event = @event.by_date(@period, @subject)

    flash[:success] = 'Evento criado com sucesso.' if @event.save
    respond_with(@event, location: period_subject_path(@period, @subject))
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event.update(event_params)
    @event = @event.by_date(@period, @subject)
    flash[:success] = 'Evento atualizado com sucesso.' if @event.save
    respond_with(@event, location: period_subject_path(@period, @subject))
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    flash[:success] = 'Evento removido com sucesso.' if @event.destroy
    respond_with(@event, location: period_subject_path(@period, @subject))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @subject = get_subject(params[:subject_id])
      @period = get_period(@subject.period_id)
      @event = @subject.events.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:start_date, :every, :end_date, :start_time, :end_time, :title, :weekday)
    end
end
