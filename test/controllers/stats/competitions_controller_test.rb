require "test_helper"

class Stats::CompetitionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stats_competition = stats_competitions(:one)
  end

  test "should get index" do
    get stats_competitions_url
    assert_response :success
  end

  test "should get new" do
    get new_stats_competition_url
    assert_response :success
  end

  test "should create stats_competition" do
    assert_difference("Stats::Competition.count") do
      post stats_competitions_url, params: { stats_competition: { game_id: @stats_competition.game_id, name: @stats_competition.name } }
    end

    assert_redirected_to stats_competition_url(Stats::Competition.last)
  end

  test "should show stats_competition" do
    get stats_competition_url(@stats_competition)
    assert_response :success
  end

  test "should get edit" do
    get edit_stats_competition_url(@stats_competition)
    assert_response :success
  end

  test "should update stats_competition" do
    patch stats_competition_url(@stats_competition), params: { stats_competition: { game_id: @stats_competition.game_id, name: @stats_competition.name } }
    assert_redirected_to stats_competition_url(@stats_competition)
  end

  test "should destroy stats_competition" do
    assert_difference("Stats::Competition.count", -1) do
      delete stats_competition_url(@stats_competition)
    end

    assert_redirected_to stats_competitions_url
  end
end
