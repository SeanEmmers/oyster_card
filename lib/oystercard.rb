class Oystercard

  STARTING_BALANCE = 0

  attr_reader :balance

  def initialize
    @balance = STARTING_BALANCE
  end

  def top_up(top_up_amount)
    fail 'Balance cannot exceed 90' if @balance + top_up_amount > 90
    @balance += top_up_amount
  end
   
end