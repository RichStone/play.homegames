class Stats::CompetitionsController < ApplicationController
  before_action :set_stats_competition, only: %i[ show edit update destroy ]

  # GET /stats/competitions or /stats/competitions.json
  def index
    @stats_competitions = Stats::Competition.all
  end

  # GET /stats/competitions/1 or /stats/competitions/1.json
  def show
  end

  # GET /stats/competitions/new
  def new
    @stats_competition = Stats::Competition.new
  end

  # GET /stats/competitions/1/edit
  def edit
  end

  # POST /stats/competitions or /stats/competitions.json
  def create
    @stats_competition = Stats::Competition.new(stats_competition_params)

    respond_to do |format|
      if @stats_competition.save
        format.html { redirect_to @stats_competition, notice: "Competition was successfully created." }
        format.json { render :show, status: :created, location: @stats_competition }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stats_competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stats/competitions/1 or /stats/competitions/1.json
  def update
    respond_to do |format|
      if @stats_competition.update(stats_competition_params)
        format.html { redirect_to @stats_competition, notice: "Competition was successfully updated." }
        format.json { render :show, status: :ok, location: @stats_competition }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stats_competition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stats/competitions/1 or /stats/competitions/1.json
  def destroy
    @stats_competition.destroy!

    respond_to do |format|
      format.html { redirect_to stats_competitions_path, status: :see_other, notice: "Competition was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stats_competition
      @stats_competition = Stats::Competition.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def stats_competition_params
      params.expect(stats_competition: [ :game_id, :name ])
    end
end
