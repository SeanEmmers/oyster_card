require_relative 'oystercard'
require_relative 'station'

class Journey

  attr_reader :complete, :entry_station, :exit_station
  attr_accessor :entry_station
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
    @exit_station = nil
  end

  def exit_station(station)
  @exit_station = station
  end

  def finish
  @exit_station == nil || @entry_station == nil ? fare : @complete = true
  end

  def complete?
    @complete
  end

  def fare
    @complete == true ? 'correct fare' : PENALTY_FARE
  end

end