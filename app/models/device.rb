class Device < ActiveRecord::Base
  attr_accessible :device_id, :update_start_date, :update_end_date, :need_update, :need_upload

  has_many :slot_logs
end
