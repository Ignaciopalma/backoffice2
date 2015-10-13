require 'test_helper'

class DeliveriesControllerTest < ActionController::TestCase
  setup do
    @delivery = deliveries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deliveries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create delivery" do
    assert_difference('Delivery.count') do
      post :create, delivery: { address_finish: @delivery.address_finish, address_start: @delivery.address_start, ciclyst_id: @delivery.ciclyst_id, comission: @delivery.comission, comuna_finish: @delivery.comuna_finish, comuna_start: @delivery.comuna_start, eta: @delivery.eta, id: @delivery.id, km: @delivery.km, lat_finish: @delivery.lat_finish, lat_start: @delivery.lat_start, long_finish: @delivery.long_finish, long_start: @delivery.long_start, pay_state: @delivery.pay_state, photo_id: @delivery.photo_id, sender_id: @delivery.sender_id, state: @delivery.state }
    end

    assert_redirected_to delivery_path(assigns(:delivery))
  end

  test "should show delivery" do
    get :show, id: @delivery
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @delivery
    assert_response :success
  end

  test "should update delivery" do
    patch :update, id: @delivery, delivery: { address_finish: @delivery.address_finish, address_start: @delivery.address_start, ciclyst_id: @delivery.ciclyst_id, comission: @delivery.comission, comuna_finish: @delivery.comuna_finish, comuna_start: @delivery.comuna_start, eta: @delivery.eta, id: @delivery.id, km: @delivery.km, lat_finish: @delivery.lat_finish, lat_start: @delivery.lat_start, long_finish: @delivery.long_finish, long_start: @delivery.long_start, pay_state: @delivery.pay_state, photo_id: @delivery.photo_id, sender_id: @delivery.sender_id, state: @delivery.state }
    assert_redirected_to delivery_path(assigns(:delivery))
  end

  test "should destroy delivery" do
    assert_difference('Delivery.count', -1) do
      delete :destroy, id: @delivery
    end

    assert_redirected_to deliveries_path
  end
end
