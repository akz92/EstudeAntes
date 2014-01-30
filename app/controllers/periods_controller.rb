class PeriodsController < ApplicationController
  before_action :set_period, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /periods
  # GET /periods.json
  def index
    @periods = current_user.periods.all
    @periods.each do |period|
      if period.current_period
        @period = period
        @subjects = period.subjects.all
      end
    end
    @periods.each do |period|
      if period.current_period
        period.subjects.all.each do |subject|
          subject.tests.each do |test|
            subject.grade += test.grade
            subject.value += test.value
          end
          subject.projects.each do |project|
            subject.grade += project.grade
            subject.value += project.value
          end
          subject.save
        end
      end
    end

  end

  def all
    @periods = current_user.periods.all
  end
  # GET /periods/1
  # GET /periods/1.json
  def show
  end

  # GET /periods/new
  def new
    @period = current_user.periods.new
  end

  # GET /periods/1/edit
  def edit
  end

  # POST /periods
  # POST /periods.json
  def create
    @period = current_user.periods.new(period_params)

    if (Date.today >= @period.init_date) && (Date.today <= @period.final_date)
      @period.current_period = true
    end

    respond_to do |format|
      if @period.save
        format.html { redirect_to @period, notice: 'Period was successfully created.' }
        format.json { render action: 'show', status: :created, location: @period }
      else
        format.html { render action: 'new' }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    respond_to do |format|
      if @period.current_period == true
        @period.current_period = false
      end
      if (Date.today >= @period.init_date) && (Date.today <= @period.final_date)
        @period.current_period = true
      end
      if @period.update(period_params)
        format.html { redirect_to @period, notice: 'Period was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
    respond_to do |format|
      format.html { redirect_to periods_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_period
      @period = current_user.periods.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def period_params
      params.require(:period).permit(:init_date, :final_date, :number)
    end
end
