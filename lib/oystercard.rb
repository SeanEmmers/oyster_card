require_relative 'station'
require_relative 'journey'
class Oystercard

  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journey_list, :exit_station, :journey

  def initialize
    @balance = STARTING_BALANCE
    @journey = nil
    @journey_list = []
  end

  def top_up(top_up_amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + top_up_amount > MAXIMUM_BALANCE
    @balance += top_up_amount
    "You now have £#{@balance}"
  end

  def touch_in(station)
    fail "You don't have the minimum balance £#{MINIMUM_FARE} to touch on" if @balance <= MINIMUM_FARE
    @entry_station = station
    @journey = Journey.new(station)
    'Touched on'
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    journey_creator
    @entry_station = nil
    @journey.exit_station(station)
    'Touched out'
  end

  def fare
    @balance -= journey.fare
  end

  def journey_creator
  @journey_list << {entry_station: @entry_station, exit_station: @exit_station}
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
    "£#{amount} has been deducted"
  end
 
end
