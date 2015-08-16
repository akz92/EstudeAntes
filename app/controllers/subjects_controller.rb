class SubjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_subject, only: [:show, :update, :destroy]
  respond_to :html, :json
  before_filter do
    @period = get_period(params[:period_id])
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = @period.subjects.new(subject_params)

    if @subject.save
      flash[:success] = 'Disciplina criada com sucesso.'# if @subject.save
    else
      flash[:error] = 'Disciplina nao pode ser criada.'
    end
    respond_with(@subject, location: choose_redirect_path(@period))
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    params[:notice] = 'Disciplina alterada com sucesso.' if @subject.update(subject_params)
    respond_with(@subject, location: period_subject_path(@period, @subject))
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    params[:notice] = 'Disciplina removida com sucesso.' if @subject.destroy
    respond_with(@subject, location: choose_redirect_path(@period))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = get_subject(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name)
    end
end
