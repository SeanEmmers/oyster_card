require 'oystercard'

describe Oystercard do
  it 'has an initialized balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up the balance' do
      expect(subject.top_up(10)).to eq 10
    end
    it 'does not exceed top up of 90' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect{ subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#deduct' do
    it 'deducts money from the card' do
      card = Oystercard.new
      card.top_up(20)
      card.deduct(10)
      expect(card.balance).to eq 10
    end
  end

  describe '#touch_in' do
    it 'updates the card to be touched on' do
      subject.top_up(20)
      subject.touch_in
      expect(subject.journey_status).to eq true
    end
    it 'raises an error if there are not enough funds to touch in' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      expect{ subject.touch_in }.to raise_error "You don't have the minimum balance £#{minimum_balance} to touch on"
    end

  end

  describe '#touch_out' do
    it 'updates the card to be touched out' do
      subject.top_up(20)
      subject.touch_in
      subject.touch_out
      expect(subject.journey_status).to eq false
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
