class ProbabilitiesController < ApplicationController
  #attr_accessible :date, :prize, :count

  def index
    @probabilities = Probability.all

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
end
