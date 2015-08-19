class TestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  before_filter do
    @subject =  get_subject(params[:subject_id])
    @period = get_period(@subject.period_id)
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = @subject.tests.new(test_params)
    @subject.update_value_and_grade('create', @test)

    if @test.save
      choose_flash_message(:success, 'adicionad')
    else
      choose_flash_message(:error, 'adicionad')
    end

    respond_with(@test, location: period_subject_path(@period, @subject))
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    choose_flash_message(:success, 'alterad') if @test.update(test_params)
    respond_with(@test, location: period_subject_path(@period, @subject))
    @subject.update_value_and_grade('update', @test)
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @subject.update_value_and_grade('destroy', @test)

    choose_flash_message(:success, 'removid') if @test.destroy
    respond_with(@test, location: period_subject_path(@period, @subject))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @subject =  get_subject(params[:subject_id])
      @test = @subject.tests.find(params[:id])
    end

    def choose_flash_message(state, type)
      error_string = ''
      error_string = 'nao pode ser'if state == :error

      if @test.is_project
        flash[state] = "Trabalho #{error_string} #{type}o."
      else
        flash[state] = "Prova #{error_string} #{type}a."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:date, :value, :grade, :note, :is_project)
    end
end
