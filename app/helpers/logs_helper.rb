module LogsHelper
  def create_formatted_logs(logs)
    array = []
    logs.each.with_index(1) do |log, i|
      log_entry = {
        index: "#{i}回目",
        start_at: "開始時刻：#{log.decorate.start_time}",
        end_at: log.end_at ? "終了時刻：#{log.decorate.end_time}" : ''
      }
      array << log_entry
    end
    array
  end
end
