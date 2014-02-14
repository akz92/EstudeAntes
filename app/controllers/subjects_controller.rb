class SubjectsController < ApplicationController
  before_action :set_subject, only: [:show, :edit, :update, :destroy]

  before_filter do
    @period = Period.find(params[:period_id])
  end

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = @period.subjects.all
    gon.subjects = @period.subjects.map &:attributes 
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @tests = @subject.tests.all
    @projects = @subject.projects.all
    gon.subject = @subject 
  end

  # GET /subjects/new
  def new
    @subject = @period.subjects.new
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    @subject = @period.subjects.new(subject_params)

    respond_to do |format|
      if @subject.save
        format.html { redirect_to period_subjects_url, notice: 'Subject was successfully created.' }
        format.json { render action: 'show', status: :created, location: @subject }
      else
        format.html { render action: 'new' }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to period_subjects_url, notice: 'Subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to period_subjects_url }
      format.json { head :no_content }
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
