module ApplicationHelper

  def navbar_select
    if @dados
      if @dados["current_period"] && @dados["period_number"] != []
        render partial: "/periods/navbar"
      elsif @dados["period_number"] != []
        render partial: "/subjects/navbar"
      else
        render partial: "/periods/initial_navbar"
      end
    elsif @dados_periodo && @dados_periodo["period_number"] != []
      render partial: "/subjects/navbar"
    end
  end

end
