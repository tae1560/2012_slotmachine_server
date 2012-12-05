class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string    :device_id
      t.datetime  :update_start_date
      t.datetime  :update_end_date
      t.boolean   :need_update
      t.boolean   :need_upload

      t.timestamps
    end
  end
end
