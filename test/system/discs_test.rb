require "application_system_test_case"

class DiscsTest < ApplicationSystemTestCase
  setup do
    @disc = discs(:one)
  end

  test "visiting the index" do
    visit discs_url
    assert_selector "h1", text: "Discs"
  end

  test "creating a Disc" do
    visit discs_url
    click_on "New Disc"

    click_on "Create Disc"

    assert_text "Disc was successfully created"
    click_on "Back"
  end

  test "updating a Disc" do
    visit discs_url
    click_on "Edit", match: :first

    click_on "Update Disc"

    assert_text "Disc was successfully updated"
    click_on "Back"
  end

  test "destroying a Disc" do
    visit discs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Disc was successfully destroyed"
  end
end
