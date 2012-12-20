class SlotLogsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render :json => SlotLog.all }
    end
  end

  def create
    json_logs = param[:json_logs]
    ret = true

    if json_logs
      parsed_json_logs = ActiveSupport::JSON.decode(json_logs)

      parsed_json_logs.each do |parsed_json_log|
        id = parsed_json_log["id"]
        db_prize = parsed_json_log["db_prize"]
        time = parsed_json_log["time"]

        slog_log = SlotLog.find(id)
        unless slog_log
          slog_log = SlotLog.create(:id => id)
        end

        slog_log.db_prize = db_prize
        slog_log.time = time

        unless slog_log.save
          ret = false
        end
      end
    end

    if ret
      render "success"
    else
      render "failed"
    end

  end
end
