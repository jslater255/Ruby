require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @user_detail = user_details(:one)
    @user_detail.user_id = @user
    session[:user_id] = @user

    @user_two = users(:two)
    @user_detail = user_details(:two)
    @user_detail.user_id = @user_two
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { email: 'Test'+@user.email,
                            firstname: @user.firstname,
                            grad_year: @user.grad_year,
                            jobs: @user.jobs,
                            phone: @user.phone,
                            surname: @user.surname}
    end
    assert_redirected_to "#{user_path(assigns(:user))}?page=1"
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    patch :update, id: @user, user: { email: @user.email, firstname: @user.firstname, grad_year: @user.grad_year, jobs: @user.jobs, phone: @user.phone, surname: @user.surname }
    assert_redirected_to "#{user_path(assigns(:user))}?page=1"
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_redirected_to "#{users_path}?page=1"
  end

  test "Get a user that is not there" do
    get :show, id: 40, page: 1
    assert_redirected_to "#{users_path}?page=1"
  end

  test "Get a user as someone else" do
    session[:user_id] = @user_two
    get :show, id: @user
    assert_redirected_to SITE_URL
  end

  test "edit a user as someone else" do
    session[:user_id] = @user_two
    patch :update, id: @user, user: { email: @user.email, firstname: @user.firstname, grad_year: @user.grad_year, jobs: @user.jobs, phone: @user.phone, surname: @user.surname }
    assert_redirected_to SITE_URL
  end

  test "should get edit as someone else" do
    session[:user_id] = @user_two
    get :edit, id: @user
    assert_redirected_to SITE_URL
  end

  test "Try to see user with no session login" do
    session[:user_id] = nil
    get :show, id: @user
    assert_redirected_to new_session_path
  end

  test "User Search" do
    # The link below is the URL I have mimicked but I missed out surname
    #http://localhost:3000/users/search?utf8=%E2%9C%93&firstname=1&surname=1&commit=Search&q=J
    session[:user_id] = @user
    get :search, firstname: 1, q:'j'
    assert_response :success
  end

end
