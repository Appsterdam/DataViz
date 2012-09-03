require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  setup do
    @company = companies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, company: { adventure: @company.adventure, console: @company.console, email_address: @company.email_address, first_name_owner: @company.first_name_owner, founded_at: @company.founded_at, fte: @company.fte, function: @company.function, game_devel: @company.game_devel, name: @company.name, pc: @company.pc, place: @company.place, postcode: @company.postcode, salutation: @company.salutation, serious: @company.serious, simulation: @company.simulation, street: @company.street, telephone_number: @company.telephone_number, type1: @company.type1, type2: @company.type2, web: @company.web, website: @company.website, year2007: @company.year2007, year2008: @company.year2008, year2009: @company.year2009 }
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    get :show, id: @company
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @company
    assert_response :success
  end

  test "should update company" do
    put :update, id: @company, company: { adventure: @company.adventure, console: @company.console, email_address: @company.email_address, first_name_owner: @company.first_name_owner, founded_at: @company.founded_at, fte: @company.fte, function: @company.function, game_devel: @company.game_devel, name: @company.name, pc: @company.pc, place: @company.place, postcode: @company.postcode, salutation: @company.salutation, serious: @company.serious, simulation: @company.simulation, street: @company.street, telephone_number: @company.telephone_number, type1: @company.type1, type2: @company.type2, web: @company.web, website: @company.website, year2007: @company.year2007, year2008: @company.year2008, year2009: @company.year2009 }
    assert_redirected_to company_path(assigns(:company))
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete :destroy, id: @company
    end

    assert_redirected_to companies_path
  end
end
