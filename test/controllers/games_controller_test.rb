require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:uno_classic)
  end

  test "should get index" do
    get games_url
    assert_response :success
  end

  test "should get new" do
    get new_game_url
    assert_response :success
  end

  test "should create game" do
    assert_difference("Game.count") do
      post games_url, params: { game: { name: "Newer Game", rules_url: "new url", shop_url: "new url" } }
    end

    assert_redirected_to game_url(Game.last)
  end

  test "should not create game with duplicate name" do
    assert_no_difference("Game.count") do
      post games_url, params: { game: { name: @game.name, rules_url: @game.rules_url, shop_url: @game.shop_url } }
    end
    assert_response :unprocessable_entity
  end

  test "should show game" do
    get game_url(@game)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_url(@game)
    assert_response :success
  end

  test "should update game" do
    patch game_url(@game), params: { game: { name: @game.name, rules_url: @game.rules_url, shop_url: @game.shop_url } }
    assert_redirected_to game_url(@game)
  end

  test "should destroy game that has no competition" do
    without_competition = games(:without_competition)
    assert_difference("Game.count", -1) do
      delete game_url(without_competition)
    end

    assert_redirected_to games_url
  end

  test "should not destroy game that has a competition" do
    assert_no_difference("Game.count") do
      delete game_url(@game)
    end

    assert_response :unprocessable_entity
  end
end
