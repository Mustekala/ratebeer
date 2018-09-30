require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name:"Koff" }
  let!(:user) { FactoryBot.create(:user) }
  
  it "when added, is saved" do  
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path  
    fill_in('beer_name', with:'Test')
    select('Weizen', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

  end

  it "when added without name, error is presented" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path  
    fill_in('beer_name', with:'')
    select('Weizen', from:'beer[style_id]')
    select('Koff', from:'beer[brewery_id]')
    click_button "Create Beer"
    
    expect(Beer.count).to be(0)
    expect(page).to have_content "Name can't be blank"

  end
end