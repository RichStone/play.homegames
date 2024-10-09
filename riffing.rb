class Game
  has_many :competitions
end

# Validates the values the user can input for a score.
class ScoreConfig
  belongs_to :competition

  validates :name, presence: true # In plural: "Points", "Goals", "Matches", "DURAK-letters" etc.

  SCORE_TYPES = [
    :numeric,
    :char_by_char, # e.g. DURAK-letters.
    :win_lose,
    :win_lose_draw,
    :multiple_winners
  ]

  SCORE_DIRECTIONS = [
    :negative,
    :positive,
    :negative_and_positive
  ]

  WHO_CAN_SCORE = [
    :everyone,
    :only_one
  ]

  validates :score_type, inclusion: { in: SCORE_TYPES }
  validates :score_direction, inclusion: { in: SCORE_DIRECTIONS }
end

class Competition
  belongs_to :game
  has_many :rounds
  has_many :players
  has_one :score_config
  has_one :game_end_strategy
end

class GameEndStrategy
  belongs_to :competition
  validates :type, presence: true
  validates :points_boundary, numericality: { only_integer: true }
  validates :rounds_boundary, numericality: { only_integer: true, greater_than: 0 }

  def human_readable_name
    raise NotImplementedError, "Every GameEndStrategy needs a human-readable name."
  end

  def game_over?
    raise NotImplementedError, "Every GameEndStrategy needs an end condition."
  end
end

class FirstToNPointsWinsGameEndStrategy < GameEndStrategy
  def human_readable_name
    "First to N points wins"
  end

  def game_over?
    competition.players.any? do |player|
      player.score >= competition.game_end_strategy.points
    end
  end
end

class HighestPointsAfterNRoundsGameEndStrategy < GameEndStrategy
  def human_readable_name
    "Highest points after N rounds wins"
  end

  def game_over?
  end
end

# TYPES = {
#   first_to_n_points_wins: "First to reach N points wins",
#   first_to_n_points_loses: "First to reach N points loses",
#   first_to_n_points_eliminated: "Players are eliminated when reaching N points",
#   highest_points_after_n_rounds_wins: "Highest points after N rounds wins",
#   lowest_points_after_n_rounds_loses: "Lowest points after N rounds wins"
# }

class CompetitionsController < ApplicationController
  def create
    @competition = Competition.new(competition_params)
    strategy_type = params[:game_end_strategy_type]

    if strategy_type.present?
      @competition.build_game_end_strategy(type: strategy_type)
    end

    if @competition.save
      # Handle successful save
    else
      # Handle save failure
    end
  end

  private

  def competition_params
    params.require(:competition).permit(:name, :game_id, :other_attributes)
  end
end

class GameEndService
  def initialize(competition)
    @competition = competition
  end

  # At the end of each round, we need to check if it's over.
  def game_end?
    @competition.game_end_strategy.game_over?
  end

  def end_game
    set_winner
  end

  def set_winner
  end
end

class Round
  belongs_to :competition
  has_many :players_scores # Store as JSONB and work through ActiveModel?
  validates :notes, length: { maximum: 280 }, allow_blank: true # For something like "lost with epaulets" in Durak.
end

class RoundsController < ApplicationController
  def create
    if @round.save
      if CompetitionEndedChecker.call(@round.competition)
        CompetitionTerminator.call(@round.competition)
      end
    end
  end
end

class PlayersScores
  belongs_to :round
  belongs_to :player

  validates :amount, allow_blank: true
  validates :tribool, inclusion: { in: [true, false] }, allow_blank: true
  validates :chars, length: { maximum: 280 }, allow_blank: true
end
