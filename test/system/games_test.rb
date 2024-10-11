require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  setup do
    @game = games(:uno_classic)
  end

  test "visiting the index" do
    visit games_url
    assert_selector "h1", text: "Games"
  end

  test "should create game" do
    visit games_url
    click_on "New game"

    fill_in "Name", with: "Newer Game"
    fill_in "Rules url", with: "new url"
    fill_in "Shop url", with: "new url"
    click_on "Create Game"

    assert_text "Game was successfully created"
    click_on "Back"
  end

  test "should update Game" do
    visit game_url(@game)
    click_on "Edit this game", match: :first

    fill_in "Name", with: @game.name
    fill_in "Rules url", with: @game.rules_url
    fill_in "Shop url", with: @game.shop_url
    click_on "Update Game"

    assert_text "Game was successfully updated"
    click_on "Back"
  end

  test "should destroy Game" do
    new_game = games(:without_competition)
    visit game_url(new_game)
    click_on "Destroy this game", match: :first

    assert_text "Game was successfully deleted"
  end
end
