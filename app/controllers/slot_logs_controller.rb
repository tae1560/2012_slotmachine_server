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
      device = Device.where(:device_id => device_id).first

      parsed_json_logs = ActiveSupport::JSON.decode(json_logs)

      parsed_json_logs.each do |parsed_json_log|
        id = parsed_json_log["id"]
        db_prize = parsed_json_log["db_prize"].to_i
        time = parsed_json_log["time"]

        #SlotLog.



        slot_log = SlotLog.where(:device_id => device.id).where(:db_id => id).first
        unless slot_log
          slot_log = SlotLog.new(:db_id => id)
          slot_log.device = device
        end
        #slot_log = SlotLog.new(:db_id => id)

        #slot_log.db_id = id
        slot_log.db_prize = db_prize
        slot_log.time = time



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
        format.html { render :json => [] }
      end
    end


  end

  def delete_duplicate
    ret = false
    @slot_logs = SlotLog.all
    @slot_logs.each do |slot_log|
      if SlotLog.where(:db_id => slot_log.db_id).where(:device_id => slot_log.device_id).size > 1
        SlotLog.where(:db_id => slot_log.db_id).where(:device_id => slot_log.device_id).each do |dup_slot_log|
          if dup_slot_log.id > slot_log.id
            @slot_logs.delete dup_slot_log
            dup_slot_log.destroy
          end
        end
      end
    end

    @slot_logs = SlotLog.all
    @slot_logs.each do |slot_log|
      if SlotLog.where(:db_id => slot_log.db_id).where(:device_id => slot_log.device_id).size > 1
        ret = true
      end
    end

    if ret
      render :json => "true"
    else
      render :json => "false"
    end
  end


  def append_logs

                 # now, do the dirty work
                 require 'net/http'
    # get the url that we need to post to
    url = URI.parse('http://soma2.vps.phps.kr:3000/slot_logs')
                 #url = URI.parse('http://www.naver.com')

    resp, data = Net::HTTP.post_form(url, { 'device_id' => Device.find(67).device_id })

    render :json => data
    #             render :json => resp
  end
end
