class Oystercard

  STARTING_BALANCE = 0
  MAXIMUM_BALANCE = 90

  attr_reader :balance
  attr_accessor :injourney

  def initialize
    @balance = STARTING_BALANCE
    @injourney = false
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
    @injourney = true
  end

  def touch_out
    @injourney = false
  end

end
