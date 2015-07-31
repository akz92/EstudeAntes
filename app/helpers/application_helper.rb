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

    #if @current_period
    #  render partial: "/periods/navbar"
    #elsif @period && @period.is_current == false
    #  render partial: "/subjects/navbar"
    #elsif @dados_periodo && @dados_periodo["period_number"] != []
    #  render partial: "/subjects/navbar"
    #else
    #  render partial: "/periods/initial_navbar"
    #end

  #def resource_name :user end 
  #def resource \@resource ||= User.new end 
  #def devise_mapping @devise_mapping ||= Devise.mappings[:user] end 
  #def resource_class User end 
end
