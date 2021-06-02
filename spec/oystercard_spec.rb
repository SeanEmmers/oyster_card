require 'oystercard'

describe Oystercard do
  it 'has an initialized balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up the balance' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
    it 'does not exceed top up of 90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#touch_in' do
    it 'updates the card to be touched on' do
      subject.top_up(20)
      subject.touch_in
      expect(subject.journey_status).to eq true
    end
    it 'raises an error if there are not enough funds to touch in' do
      minimum_fare = Oystercard::MINIMUM_FARE
      expect{ subject.touch_in }.to raise_error "You don't have the minimum balance £#{minimum_fare} to touch on"
    end

  end

  describe '#touch_out' do
    it 'updates the card to be touched out' do
      subject.top_up(20)
      subject.touch_in
      subject.touch_out
      expect(subject.journey_status).to eq false
    end
    it 'deducts a minimum fare when touching out' do 
      minimum_fare = Oystercard::MINIMUM_FARE - Oystercard::MINIMUM_FARE*2
      subject.top_up(20)
      subject.touch_in
      expect { subject.touch_out }.to change{ subject.balance }.by(minimum_fare)
    end
  end

  describe '#in_journey?' do
    it 'lets us know if we are touched on' do
      subject.top_up(20)
      subject.touch_in
      expect(subject.in_journey?).to eq 'In use'
    end
    it 'lets us know if we are touched on' do
      subject.top_up(20)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq 'Not touched on'
    end
  end
end
