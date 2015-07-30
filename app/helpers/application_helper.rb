module ApplicationHelper

  def tab(value)
   @active_tab = value
  end

  def navbar_select
    case @active_tab
    when "period"
      render partial: "/periods/navbar"
    #when "other_period"
    #  render partial: "/periods/other_period_navbar"
    when "subject"
      render partial: "/subjects/navbar"
    else
      render partial: "/devise/sessions/navbar"
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
  end

  #def resource_name :user end 
  #def resource \@resource ||= User.new end 
  #def devise_mapping @devise_mapping ||= Devise.mappings[:user] end 
  #def resource_class User end 
end
