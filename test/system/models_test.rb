require "application_system_test_case"

class ModelsTest < ApplicationSystemTestCase
  setup do
    @model = models(:one)
  end

  test "visiting the index" do
    visit models_url
    assert_selector "h1", text: "Models"
  end

  test "should create model" do
    visit models_url
    click_on "New model"

    fill_in "Address", with: @model.address
    check "Admin" if @model.admin
    fill_in "Born date", with: @model.born_date
    fill_in "Firstname", with: @model.firstname
    check "Inspector" if @model.inspector
    fill_in "Login", with: @model.login
    fill_in "Middlename", with: @model.middlename
    fill_in "Passport", with: @model.passport
    fill_in "Password", with: @model.password
    fill_in "Surname", with: @model.surname
    click_on "Create Model"

    assert_text "Model was successfully created"
    click_on "Back"
  end

  test "should update Model" do
    visit model_url(@model)
    click_on "Edit this model", match: :first

    fill_in "Address", with: @model.address
    check "Admin" if @model.admin
    fill_in "Born date", with: @model.born_date
    fill_in "Firstname", with: @model.firstname
    check "Inspector" if @model.inspector
    fill_in "Login", with: @model.login
    fill_in "Middlename", with: @model.middlename
    fill_in "Passport", with: @model.passport
    fill_in "Password", with: @model.password
    fill_in "Surname", with: @model.surname
    click_on "Update Model"

    assert_text "Model was successfully updated"
    click_on "Back"
  end

  test "should destroy Model" do
    visit model_url(@model)
    click_on "Destroy this model", match: :first

    assert_text "Model was successfully destroyed"
  end
end
