class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :prepare_unobtrusive_flash

  private
  def choose_redirect_path(period)
    if period.is_current
      root_path
    else
      period_subjects_path(period)
    end
  end

  def get_period(period_id)
    Period.find(period_id)
  end

  def get_subject(subject_id)
    Subject.find(subject_id)
  end

end
