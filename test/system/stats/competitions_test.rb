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

    # Use select to choose an option from the dropdown
    select Game.find(@stats_competition.game_id).name, from: "Game"

    fill_in "Name", with: @stats_competition.name
    click_on "Create Competition"

    assert_text "Competition was successfully created"
    click_on "Back"
  end

  test "should update Competition" do
    visit stats_competition_url(@stats_competition)
    click_on "Edit this competition", match: :first

    # Check if the name field is pre-filled with the correct value
    assert_field "Name", with: "Competition ##{@stats_competition.id}"

    # Use select to choose an option from the dropdown
    select Game.find(@stats_competition.game_id).name, from: "Game"

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
