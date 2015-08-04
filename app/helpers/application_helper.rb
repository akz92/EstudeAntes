module ApplicationHelper
	# Set the style of the Bootstrap Message
	#
	# @param level [String] the alert type
	# @return [String] the corresponding alert type
  def flash_class(level)
    case level
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-warning'
    else 'alert alert-info'
    end
  end
end
