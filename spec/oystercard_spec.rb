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
      subject.touch_in
      expect(subject.injourney).to eq true
    end
  end

  describe '#touch_out' do
    it 'updates the card to be touched out' do
      subject.touch_in
      subject.touch_out
      expect(subject.injourney).to eq false
    end
  end
end
