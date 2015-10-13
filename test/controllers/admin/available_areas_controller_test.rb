require 'test_helper'

class Admin::AvailableAreasControllerTest < ActionController::TestCase
  setup do
    @admin_available_area = admin_available_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_available_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_available_area" do
    assert_difference('Admin::AvailableArea.count') do
      post :create, admin_available_area: { name: @admin_available_area.name }
    end

    assert_redirected_to admin_available_area_path(assigns(:admin_available_area))
  end

  test "should show admin_available_area" do
    get :show, id: @admin_available_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_available_area
    assert_response :success
  end

  test "should update admin_available_area" do
    patch :update, id: @admin_available_area, admin_available_area: { name: @admin_available_area.name }
    assert_redirected_to admin_available_area_path(assigns(:admin_available_area))
  end

  test "should destroy admin_available_area" do
    assert_difference('Admin::AvailableArea.count', -1) do
      delete :destroy, id: @admin_available_area
    end

    assert_redirected_to admin_available_areas_path
  end
end
