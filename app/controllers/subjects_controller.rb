class SubjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  before_filter do
    @period = Period.find(params[:period_id])
  end

  # GET /subjects
  # GET /subjects.json
  def index
    gon.subjects = @period.subjects.map &:attributes
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @dados = Subject.get_tests_and_projects(@subject)
    gon.subject = @subject
  end

  # GET /subjects/new
  def new
    @subject = @period.subjects.new
  end

  # GET /subjects/1/edit
  def edit
    @subject = @period.subjects.find(params[:id])
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = @period.subjects.new(subject_params)

    params[:notice] = "Disciplina criada com sucesso." if @subject.save
    respond_with(@subject) do |format|
      if @period.is_current
        format.html { redirect_to root_path }
      else
        format.html { redirect_to period_subjects_path(@period) }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    params[:notice] = "Disciplina alterada com sucesso." if @subject.update(subject_params)
    respond_with(@subject, location: period_subject_path(@period, @subject))
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    params[:notice] = "Disciplina removida com sucesso." if @subject.destroy
    respond_with(@subject) do |format|
      if @period.is_current
        format.html { redirect_to root_url }
      else
        format.html { redirect_to period_subjects_path(@period, @subject) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @period = Period.find(params[:period_id])
      @subject = @period.subjects.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:name)
    end
end
