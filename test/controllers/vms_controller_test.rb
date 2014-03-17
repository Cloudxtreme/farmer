require 'test_helper'

class VmsControllerTest < ActionController::TestCase
  setup do
    @vm = vms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vm" do
    assert_difference('Vm.count') do
      post :create, vm: { domain: @vm.domain, name: @vm.name, server_id: @vm.server_id }
    end

    assert_redirected_to vm_path(assigns(:vm))
  end

  test "should show vm" do
    get :show, id: @vm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vm
    assert_response :success
  end

  test "should update vm" do
    patch :update, id: @vm, vm: { domain: @vm.domain, name: @vm.name, server_id: @vm.server_id }
    assert_redirected_to vm_path(assigns(:vm))
  end

  test "should destroy vm" do
    assert_difference('Vm.count', -1) do
      delete :destroy, id: @vm
    end

    assert_redirected_to vms_path
  end
end
