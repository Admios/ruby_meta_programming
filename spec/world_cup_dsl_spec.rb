require 'rspec'
require_relative '../lib/world_cup_dsl'

describe WorldCupDSL do

  before :each do
    @wc_dsl = WorldCupDSL.new 'data.csv'
  end

  after :each do
    @wc_dsl = nil
  end

  it 'should find all of the players by country' do
    @wc_dsl.where(:country, "Argentina")
    expect(@wc_dsl.data.size).to eq(23)
  end

  it 'should find all of the players by multiple conditions' do
    @wc_dsl.where(:country, "Argentina")
    @wc_dsl.where(:height, '175')
    expect(@wc_dsl.data).to eq([{:country=>"Argentina", :number=>12, :position=>"Defender", :fifa_display_name=>"Ariel GARCE",
                                 :last_name=>"GARCE", :first_name=>"Ariel Hernan", :shirt_name=>"GARCE", :dob=>"14 Jul 1979",
                                 :club=>"Atletico Colon", :club_country=>"ARG", :height=>175}])
  end

  it 'should work with dynamic methods' do
    @wc_dsl.country "Argentina"
    expect(@wc_dsl.data.size).to eq(23)
  end


  it 'should work with a block and dynamic methods' do
    result = @wc_dsl.query do
      country "Argentina"
    end
    expect(result.size).to eq(23)
  end

  it 'should work with a block, dynamic methods and multiple conditions' do
    result = @wc_dsl.query do
      country "Argentina"
      height '175'
    end
    expect(result.size).to eq(1)
  end

end