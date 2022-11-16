require 'rails_helper'

RSpec.describe Holiday do
  it 'exists and has upcoming_holidays attribute' do
    data = [{:date=>"2022-11-24",
             :localName=>"Thanksgiving Day",
             :name=>"Thanksgiving Day",
             :countryCode=>"US",
             :fixed=>false,
             :global=>true,
             :counties=>nil,
             :launchYear=>1863,
             :types=>["Public"]},
            {:date=>"2022-12-26",
             :localName=>"Christmas Day",
             :name=>"Christmas Day",
             :countryCode=>"US",
             :fixed=>false,
             :global=>true,
             :counties=>nil,
             :launchYear=>nil,
             :types=>["Public"]}]
    holidays = Holiday.new(data)
    expect(holidays).to be_an_instance_of(Holiday)
    expect(holidays.upcoming_holidays).to be_a(Hash)
    expect(holidays.upcoming_holidays).to eq({"Thanksgiving Day" => "2022-11-24", "Christmas Day" => "2022-12-26"})
  end
end
