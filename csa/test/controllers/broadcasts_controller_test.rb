require 'test_helper'

class BroadcastsControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user_detail = user_details(:one)
    @user_detail.user_id = @user
    session[:user_id] = @user
    @broadcast = broadcasts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:broadcasts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create broadcast" do

    @feeds = {alumni_email: 'cs-alumni', facebook: 1, RSS: 1, twitter: 1, email: 1}
    assert_difference('Broadcast.count') do
      post :create, broadcast: { content: @broadcast.content, user_id: @user}, feeds: @feeds
    end
    assert_response :success
  end

  test "should show broadcast" do
    get :show, id: @broadcast
    assert_response :success
  end

  test "should destroy broadcast" do
    assert_difference('Broadcast.count', -1) do
      delete :destroy, id: @broadcast
    end

    assert_redirected_to broadcasts_path
  end

  test "Broadcast to_s" do
    result = "id: " + @broadcast.id.to_s + " content: " + @broadcast.content #+ " user: " + @user.id.to_s
    assert_equal(result, @broadcast.to_s, 'broadcast.to_s Error')
  end

  test "Get a broadcast that is not there" do
    get :show, id: 4, page: 1
    assert_redirected_to broadcasts_path#"#{broadcasts_path}?page=1"
  end

  #test "Get the feeds for a broadcast" do
    #assert_equal('Email, Facebook, Rss', BroadcastsHelper.display_feeds(@broadcast), 'Feeds match the return string')
  #end
end
