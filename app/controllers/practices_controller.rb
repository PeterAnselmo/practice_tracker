class PracticesController < ApplicationController
  before_action :set_practice, only: %i[ show edit update destroy ]

    def landing
        if params[:item_id]
            @item = Item.find(params[:item_id])
        else
            @item = Item.where(active:true).order('random()').limit(1).first
        end
    end
  
  # GET /practices or /practices.json
  def index
      @practices = Practice.order('start_time desc').limit(200)
      @day_total = Practice.where("start_time > '#{Time.now.beginning_of_day.utc}'").map{|p| p.end_time - p.start_time}.sum.to_i.to_descriptive_time
      @week_total = Practice.where("start_time > '#{Time.now.beginning_of_week.utc}'").map{|p| p.end_time - p.start_time}.sum.to_i.to_descriptive_time
  end

  # GET /practices/1 or /practices/1.json
  def show
  end

  # GET /practices/new
  def new
    @practice = Practice.new
  end

  # GET /practices/1/edit
  def edit
  end

  # POST /practices or /practices.json
  def create
    @practice = Practice.new(practice_params)
	@practice.end_time ||= Time.now
	unless @practice.start_time.present?
		if params[:duration].present?
			parts = params[:duration].split(":")
			if parts.size == 3
				hours, minutes, seconds = parts
            elsif parts.size == 2
                hours = 0
                minutes, seconds = parts
            else
                raise "Invalid duration: #{params[:duration]}"
            end
            @practice.start_time = @practice.end_time - hours.to_i.hours - minutes.to_i.minutes - seconds.to_i.seconds
		else
            raise "Start time or duration required"
		end
	end

    respond_to do |format|
      if @practice.save
        format.html { redirect_to practice_url(@practice), notice: "Practice was successfully created." }
        format.json { render :show, status: :created, location: @practice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practices/1 or /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to practice_url(@practice), notice: "Practice was successfully updated." }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1 or /practices/1.json
  def destroy
    @practice.destroy

    respond_to do |format|
      format.html { redirect_to practices_url, notice: "Practice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

    def report
        @practices = Practice.find_by_sql("select items.name, sum((julianday(practices.end_time) - julianday(practices.start_time))*86400) as duration
                                         from practices
                                         inner join items on practices.item_id = items.id
                                         where practices.created_at > '#{4.weeks.ago.utc}'
                                         group by items.name
                                         order by sum((julianday(practices.end_time) - julianday(practices.start_time))*86400) desc")

    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def practice_params
      params.require(:practice).permit(:item_id, :start_time, :end_time, :duration)
    end
end
