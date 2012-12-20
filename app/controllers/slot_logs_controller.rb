class SlotLogsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render :json => SlotLog.all }
    end
  end

  def create
    #json_logs = param["json_logs"]
    #params = params.gsub(/[\]]/,"")

    json_logs = params[:json_logs]
    device_id = params[:device_id]

    ret = true

    added_id = []
    if json_logs and device_id
      parsed_json_logs = ActiveSupport::JSON.decode(json_logs)

      parsed_json_logs.each do |parsed_json_log|
        id = parsed_json_log["id"]
        db_prize = parsed_json_log["db_prize"].to_i
        time = parsed_json_log["time"]

        #SlotLog.
        if SlotLog.where(:db_id => id).exists?
          slot_log = SlotLog.where(:db_id => id).first
        else
          slot_log = SlotLog.new(:db_id => id)
        end

        slot_log.db_id = id
        slot_log.db_prize = db_prize
        slot_log.time = time

        device = Device.where(:device_id => device_id).first
        slot_log.device = device

        if slot_log.save
          added_id.push id
        else
          ret = false
        end
      end
    end

    #slot_log = SlotLog.first

    respond_to do |format|
      if ret
        #format.html { render :json => "success" }
        format.html { render :json => added_id }
      else
        format.html { render :json => "failed" }
      end
    end


  end
end
