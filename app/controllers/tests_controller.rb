class TestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  before_filter do
    @period = Period.find(params[:period_id])
    @subject = @period.subjects.find(params[:subject_id])
  end

  # GET /tests
  # GET /tests.json
  def index
    # @tests = @subject.tests.all
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = @subject.tests.new
  end

  # GET /tests/trabalho
  def trabalho
    # @test = @subject.tests.new
  end

  # GET /tests/1/edit
  def edit
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = @subject.tests.new(test_params)

    @subject.value += @test.value
    @subject.grade += @test.grade
    @subject.save!

    choose_flash_message if @test.save
    respond_with(@test, location: period_subject_path(@period, @subject))
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    choose_flash_message if @test.save
    respond_with(@test, location: period_subject_path(@period, @subject))

    @subject.value = 0
    @subject.grade = 0

    @subject.tests.each do |test|
      @subject.value += test.value
      @subject.grade += test.grade
    end

    @subject.save!
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @subject.value -= @test.value
    @subject.grade -= @test.grade
    @subject.save!

    choose_flash_message if @test.destroy
    respond_with(@test, location: period_subject_path(@period, @subject))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = @subject.tests.find(params[:id])
    end

    def choose_flash_message
      if @test.is_project
        flash[:success] = 'Trabalho adicionado com sucesso.'
      else
        flash[:success] = 'Prova adicionada com sucesso.'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:date, :value, :grade, :note, :is_project)
    end
end
