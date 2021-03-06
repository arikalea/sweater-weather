class DailyForecast
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = Time.zone.at(data[:dt])
    @sunrise = Time.zone.at(data[:sunrise])
    @sunset = Time.zone.at(data[:sunset])
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def self.next_five_days(data)
    data.take(5).map do |daily_data|
      DailyForecast.new(daily_data)
    end
  end
end
