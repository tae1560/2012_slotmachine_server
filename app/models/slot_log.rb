class SlotLog < ActiveRecord::Base
  attr_accessible :db_id, :db_prize, :time

  belongs_to :device
end
