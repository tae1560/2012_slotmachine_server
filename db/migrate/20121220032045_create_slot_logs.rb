class CreateSlotLogs < ActiveRecord::Migration
  def change
    create_table :slot_logs do |t|
      t.integer :db_prize
      t.datetime :time

      t.timestamps
    end
  end
end
