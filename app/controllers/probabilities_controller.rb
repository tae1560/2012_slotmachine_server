class ProbabilitiesController < ApplicationController
  #attr_accessible :date, :prize, :count

  def index
    device_id = params[:device_id]

    unless device_id
      device_id = ""
    end

    @probabilities = []
    if device_id.include? "ski"
      @probabilities = Probability.where(:pro_type => 2).all
    elsif device_id.include? "mart"
      @probabilities = Probability.where(:pro_type => 1).all
    elsif device_id.include? "taeho"
      @probabilities = Probability.where(:pro_type => 10).all
    end

    respond_to do |format|
      format.html
      format.json { render json: @probabilities }
    end
  end

  def new
    @probability = Probability.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @probability }
    end
  end

  def create
    @probability = Probability.new(params[:probability])

    pre_probability = Probability.where(:date => @probability.date, :prize => @probability.prize).first

    if pre_probability
      pre_probability.count = @probability.count
      @probability = pre_probability
    end

    respond_to do |format|
      if @probability.save
        format.html { redirect_to probabilities_path, notice: 'Post was successfully created.' }
        format.json { render json: @probability, status: :created, location: @probability }
      else
        format.html { render action: "new" }
        format.json { render json: @probability.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @probability = Probability.find(params[:id])
    @probability.destroy

    respond_to do |format|
      format.html { redirect_to probabilities_path }
      format.json { head :no_content }
    end
  end

  def initialize_data
    Probability.destroy_all

    #"06/12/2012".to_date.upto("19/12/2012".to_date) do |day|
    #  count = [0,1,1,1,1]
    #  make_new_probability day, count
    #end

    # mart
    "22/12/2012".to_date.upto("23/12/2012".to_date) do |day|
      count = [0,0,1,5,190]


      if day == "22/12/2012".to_date
        count[1] = 1
      end
      make_new_probability day, count, 1
    end

    "28/12/2012".to_date.upto("30/12/2012".to_date) do |day|
      count = [0,0,1,5,190]

      make_new_probability day, count, 1
    end

    # ski
    "22/12/2012".to_date.upto("23/12/2012".to_date) do |day|
      count = [0,1,4,36,100]
      make_new_probability day, count, 2
    end

    # for test taeho
    "21/12/2012".to_date.upto("30/12/2012".to_date) do |day|
      count = [0,0,1,1,10]
      make_new_probability day, count, 10
    end

    respond_to do |format|
      format.json { render :json => Probability.all }
    end
  end

  def make_new_probability day, count, pro_type
    for prize in 1..4
      pre_probability = Probability.where(:date => day, :prize => prize, :pro_type => pro_type).first
      if pre_probability == nil
        pre_probability = Probability.new
      end
      pre_probability.date = day + 9.hours - 9.hours
      pre_probability.prize = prize
      pre_probability.count = count[prize]
      pre_probability.pro_type = pro_type
      pre_probability.save
    end
  end
end
