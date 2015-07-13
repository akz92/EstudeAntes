module ApplicationHelper

  def navbar_select
    if @dados
      if @dados["current_period"]
      render partial: "/periods/navbar"
      else
        render partial: "/subjects/navbar"
      end
    elsif @dados_periodo
      render partial: "/subjects/navbar"
    else
      render partial: "/devise/sessions/navbar"
    end
  end

end
