module ApplicationHelper
  # handler for adding bootstrap styles to flash messages
  def alert_for(flash_type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    } [flash_type.to_sym] || flash_type.to_s
  end
end
