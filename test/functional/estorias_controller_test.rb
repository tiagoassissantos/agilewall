require 'test_helper'

class EstoriasControllerTest < ActionController::TestCase
  setup do
    @estoria = estorias(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estorias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estoria" do
    assert_difference('Estoria.count') do
      post :create, :estoria => @estoria.attributes
    end

    assert_redirected_to estoria_path(assigns(:estoria))
  end

  test "should show estoria" do
    get :show, :id => @estoria.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @estoria.to_param
    assert_response :success
  end

  test "should update estoria" do
    put :update, :id => @estoria.to_param, :estoria => @estoria.attributes
    assert_redirected_to estoria_path(assigns(:estoria))
  end

  test "should destroy estoria" do
    assert_difference('Estoria.count', -1) do
      delete :destroy, :id => @estoria.to_param
    end

    assert_redirected_to estorias_path
  end
end
