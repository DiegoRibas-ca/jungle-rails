require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "add a product to cart" do 
    # puts Product.all.inspect
    # ACT
    visit root_path

    # first('.product').click_link('Add')
    # within first('article.product') do
    #   click_link('Add')
    # end
    within first(".product") do
      click_on(class: 'add-product')
    end
    # sleep 1
    # puts page.html
    
    # DEBUG / VERIFY
    
    
    # puts page.html
    expect(page).to have_content("My Cart (1)")
    save_screenshot
    
  end
end
