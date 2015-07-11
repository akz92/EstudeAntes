class TestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  before_filter do
    @period = Period.find(params[:period_id])
    @subject = @period.subjects.find(params[:subject_id])
  end

  # GET /tests
  # GET /tests.json
  def index
    @tests = @subject.tests.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = @subject.tests.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = @subject.tests.new(test_params)
    @test.is_project = params[:test][:is_project]
    @test.subject_name = @subject.name
    #@test.is_project = params[:bool]
    if params[:commit] == "Salvar prova"
      @test.is_project = false
    elsif params[:commit] == "Salvar trabalho"
      @test.is_project = true
    end

    @subject.value += @test.value
    @subject.grade += @test.grade
    @subject.save

    respond_to do |format|
      if @test.save
        format.html { redirect_to period_subject_path(@period, @subject), notice: 'Test was successfully created.' }
        format.json { render action: 'show', status: :created, location: @test }
      else
        format.html { render action: 'new' }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    @test.is_project = params[:test][:is_project]
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to period_subject_path(@period, @subject), notice: 'Test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end

    @subject.value = 0
    @subject.grade = 0

    @subject.tests.each do |test|
      @subject.value += test.value
      @subject.grade += test.grade
    end

    @subject.save

  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @subject.value -= @test.value
    @subject.grade -= @test.grade
    @subject.save

    @test.destroy
    redirect_to period_subject_path(@period, @subject)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @period = Period.find(params[:period_id])
      @subject = @period.subjects.find(params[:subject_id])
      @test = @subject.tests.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:date, :value, :grade, :note, :is_project)
    end
end
