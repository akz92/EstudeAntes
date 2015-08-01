module ApplicationHelper

  def tab(value)
   @active_tab = value
  end

  def navbar_select
    case @active_tab
    when "period"
      render partial: "/periods/navbar"
    when "subject"
      render partial: "/subjects/navbar"
    else
      render partial: "/devise/sessions/navbar"
    end
  end

  def alert_class_for(flash_type)
    {
      :success => 'alert-success',
      :error => 'alert-danger',
      :alert => 'alert-warning',
      :notice => 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end 
end
