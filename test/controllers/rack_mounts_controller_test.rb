require 'test_helper'

class RackMountsControllerTest < ActionController::TestCase
  setup do
    @rack_mount = rack_mounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rack_mounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rack_mount" do
    assert_difference('RackMount.count') do
      post :create, rack_mount: { name: @rack_mount.name }
    end

    assert_redirected_to rack_mount_path(assigns(:rack_mount))
  end

  test "should show rack_mount" do
    get :show, id: @rack_mount
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rack_mount
    assert_response :success
  end

  test "should update rack_mount" do
    patch :update, id: @rack_mount, rack_mount: { name: @rack_mount.name }
    assert_redirected_to rack_mount_path(assigns(:rack_mount))
  end

  test "should destroy rack_mount" do
    assert_difference('RackMount.count', -1) do
      delete :destroy, id: @rack_mount
    end

    assert_redirected_to rack_mounts_path
  end
end
