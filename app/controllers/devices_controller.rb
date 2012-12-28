class DevicesController < ApplicationController
  def index
    @devices = Device.all
    @is_debug = params["debug"]

    respond_to do |format|
      format.html
      format.json { render json: @devices }
    end
  end

  def information
    device_id = params[:device_id]
    @device = Device.where(:device_id => device_id).first

    if @device == nil
      @device = Device.new(:device_id => device_id, :need_update => true)
    end

    update_start_date = params[:update_start_date]
    update_end_date = params[:update_end_date]

    if update_start_date
      @device.update_start_date = update_start_date
    end

    if update_end_date
      @device.update_end_date = update_end_date
      @device.need_update = false
    end

    @device.save

    respond_to do |format|
      format.json { render json: @device }
    end
  end

  def show
    @device = Device.find(params[:id])
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      format.html { redirect_to devices_path }
      format.json { head :no_content  }
    end
  end
end
