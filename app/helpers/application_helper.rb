module ApplicationHelper

  def navbar_select
    if @current_period
      render partial: "/periods/navbar"
    elsif @period && @period.current_period == false
      render partial: "/subjects/navbar"
    elsif @dados_periodo && @dados_periodo["period_number"] != []
      render partial: "/subjects/navbar"
    else
      render partial: "/periods/initial_navbar"
    end
  end

  #def resource_name :user end 
  #def resource \@resource ||= User.new end 
  #def devise_mapping @devise_mapping ||= Devise.mappings[:user] end 
  #def resource_class User end 
end
