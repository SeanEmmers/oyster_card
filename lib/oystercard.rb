class Oystercard

  STARTING_BALANCE = 0

  attr_reader :balance

  def initialize
    @balance = STARTING_BALANCE
  end

  def top_up(top_up_amount)
    @balance += top_up_amount
  end
   
end
