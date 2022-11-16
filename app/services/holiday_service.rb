require 'httparty'
require 'pry'


class HolidayService
  def holidays
    response = HTTParty.get('https://date.nager.at/api/v3/NextPublicHolidays/US')
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end

# require "pry"; binding.pry

# holidays = parsed.map do |data|
#   Holiday.new(data)
# end
