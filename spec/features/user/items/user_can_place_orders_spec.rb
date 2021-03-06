require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do

    user = create(:user)
    role = create(:registered_user)
    user.roles << role
    category = create(:category)
    item = create(:item, category: category)

    visit items_path

    click_on "Add to cart"

    visit cart_path

    within(".checkout") do
      click_on("Login")
    end

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password

    within(".action") do
      click_on("Login")
    end

    click_on "Cart"

    expect(page).to have_content("Checkout")

    click_on "Checkout"

    expect(current_path).to eq('/orders')
    expect(page).to have_content("Order was successfully placed")
  end
end
