class HourlyForecast
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = Time.at(data[:dt])
    @temperature = data[:temp]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def self.eight_hour(data)
    data.take(8).map do |hr_data|
      HourlyForecast.new(hr_data)
    end
  end
end
