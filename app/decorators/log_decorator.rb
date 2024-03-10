class LogDecorator < Draper::Decorator
  delegate_all

  def start_time
    object.start_at.strftime("%H:%M")
  end

  def end_time
    object.end_at&.strftime("%H:%M")
  end
end
