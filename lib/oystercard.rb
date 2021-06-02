class Oystercard

  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance
  attr_accessor :journey_status

  def initialize
    @balance = STARTING_BALANCE
    @journey_status = false
  end

  def top_up(top_up_amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if @balance + top_up_amount > MAXIMUM_BALANCE
    @balance += top_up_amount
  end

  def deduct(amount)
    @balance -= amount
    "£#{amount} has been deducted"
  end

  def touch_in
    fail "You don't have the minimum balance £#{MINIMUM_BALANCE} to touch on" if @balance <= MINIMUM_BALANCE
    @journey_status = true
    'Touched on'
  end

  def touch_out
    @journey_status = false
    'Touched off'
  end

  def in_journey?
    @journey_status == true ? 'In use' : 'Not touched on'
  end

end
