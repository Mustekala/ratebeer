require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is not saved without name" do
    beer = Beer.create style: "lager"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end  
  
  it "is not saved without style" do
    beer = Beer.create name: "bisse"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
  
  describe "with a proper name, brewery and style" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }
    let(:beer){ Beer.create name:"bisse", style:"lager", brewery: test_brewery }  

    it "is saved" do  
      expect(beer).to be_valid
    end  
  end  
end
