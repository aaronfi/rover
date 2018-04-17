require 'test_helper'

class HomeControllerTest < ActionController::TestCase
    setup do
        @sitters = users(:sitter1, :sitter2)
    end

    test "should get index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:sitters)
    end
end
