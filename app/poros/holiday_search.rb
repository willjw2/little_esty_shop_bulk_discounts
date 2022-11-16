require './app/services/holiday_service'
require './app/poros/holiday'


class HolidaySearch
  def holiday_info
    holidays = Holiday.new(service.holidays)
  end
  def service
    HolidayService.new
  end
end

# test = HolidaySearch.new
# require "pry"; binding.pry
