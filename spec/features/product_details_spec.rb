require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "go to product detail page by clicking on a product" do 
    # puts Product.all.inspect
    # ACT
    visit root_path

    # sleep 1
    
    within first('.product') do
      click_on "Details"
    end

    # DEBUG / VERIFY
    
    # puts page.html
    
    # puts page.html
    expect(page).to have_css '.form-review'
    save_screenshot
    
  end
end
