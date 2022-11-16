class Holiday
  attr_reader :upcoming_holidays

  def initialize(data)
    # require "pry"; binding.pry
    @upcoming_holidays = {}
    next_three_holidays = data[0..2]
    next_three_holidays.each do |holiday|
      @upcoming_holidays[holiday[:name]] = holiday[:date]
    end
    # require "pry"; binding.pry
  end
end
