require 'test_helper'

class PuzzleViewingsControllerTest < ActionController::TestCase
  setup do
    @puzzle_viewing = puzzle_viewings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:puzzle_viewings)
  end
end
