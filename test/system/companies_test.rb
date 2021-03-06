require "application_system_test_case"

class CompaniesTest < ApplicationSystemTestCase
  setup do
    @company = companies(:one)
  end

  test "visiting the index" do
    visit companies_url
    assert_selector "h1", text: "Companies"
  end

  test "creating a Company" do
    visit companies_url
    click_on "New Company"

    fill_in "Adress", with: @company.adress
    fill_in "City", with: @company.city_id
    fill_in "Cnpj", with: @company.cnpj
    fill_in "Company type", with: @company.company_type
    fill_in "District", with: @company.district
    fill_in "Name", with: @company.name
    fill_in "Number", with: @company.number
    fill_in "Phone", with: @company.phone
    fill_in "Zipcode", with: @company.zipcode
    click_on "Create Company"

    assert_text "Company was successfully created"
    click_on "Back"
  end

  test "updating a Company" do
    visit companies_url
    click_on "Edit", match: :first

    fill_in "Adress", with: @company.adress
    fill_in "City", with: @company.city_id
    fill_in "Cnpj", with: @company.cnpj
    fill_in "Company type", with: @company.company_type
    fill_in "District", with: @company.district
    fill_in "Name", with: @company.name
    fill_in "Number", with: @company.number
    fill_in "Phone", with: @company.phone
    fill_in "Zipcode", with: @company.zipcode
    click_on "Update Company"

    assert_text "Company was successfully updated"
    click_on "Back"
  end

  test "destroying a Company" do
    visit companies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Company was successfully destroyed"
  end
end
