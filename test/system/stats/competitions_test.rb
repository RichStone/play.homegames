require "application_system_test_case"

class Stats::CompetitionsTest < ApplicationSystemTestCase
  setup do
    @stats_competition = stats_competitions(:one)
  end

  test "visiting the index" do
    visit stats_competitions_url
    assert_selector "h1", text: "Competitions"
  end

  test "should create competition" do
    visit stats_competitions_url
    click_on "New competition"

    fill_in "Game", with: @stats_competition.game_id
    fill_in "Name", with: @stats_competition.name
    click_on "Create Competition"

    assert_text "Competition was successfully created"
    click_on "Back"
  end

  test "should update Competition" do
    visit stats_competition_url(@stats_competition)
    click_on "Edit this competition", match: :first

    fill_in "Game", with: @stats_competition.game_id
    fill_in "Name", with: @stats_competition.name
    click_on "Update Competition"

    assert_text "Competition was successfully updated"
    click_on "Back"
  end

  test "should destroy Competition" do
    visit stats_competition_url(@stats_competition)
    click_on "Destroy this competition", match: :first

    assert_text "Competition was successfully destroyed"
  end
end
