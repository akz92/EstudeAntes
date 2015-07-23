module ApplicationHelper

  def navbar_select
    if @current_period
      render partial: "/periods/navbar"
    elsif @period
      render partial: "/subjects/navbar"
    elsif @dados_periodo && @dados_periodo["period_number"] != []
      render partial: "/subjects/navbar"
    else
      render partial: "/periods/initial_navbar"
    end
  end

end
