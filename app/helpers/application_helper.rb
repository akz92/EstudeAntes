module ApplicationHelper
  def flash_class(level)
    case level
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-warning'
    else 'alert alert-info'
    end
  end
end
