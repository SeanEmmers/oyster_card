require 'oystercard'

describe Oystercard do
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:station){ double :station }
  maximum_balance = Oystercard::MAXIMUM_BALANCE

  it 'has an initialized balance of 0' do
    starting_balance = Oystercard::STARTING_BALANCE
    expect(subject.balance).to eq starting_balance
  end
  it 'has an empty journey list to begin' do
    expect(subject.journey_list).to be_empty
  end
  it 'stores a journey' do
    subject.top_up(20)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journey_list).to include journey
  end     

  describe '#top_up' do
    it 'tops up the balance' do
      subject.top_up(20)
      expect(subject.balance).to eq 20
    end
    it 'does not exceed top up of 90' do
      expect{ subject.top_up(maximum_balance + 1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#touch_in' do
    it 'stores the entry station' do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
    it 'updates the card to be touched on' do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end
    it 'raises an error if there are not enough funds to touch in' do
      minimum_fare = Oystercard::MINIMUM_FARE
      expect{ subject.touch_in(station) }.to raise_error "You don't have the minimum balance £#{minimum_fare} to touch on"
    end

  end

  describe '#touch_out' do
    it 'updates the card to be touched out' do
      subject.top_up(20)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq false
    end
    it 'deducts a minimum fare when touching out' do 
      minimum_fare = Oystercard::MINIMUM_FARE - Oystercard::MINIMUM_FARE*2
      subject.top_up(20)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(minimum_fare)
    end
    it 'stores exit station' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

  describe '#in_journey?' do
    it 'lets us know if we are touched on' do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq true
    end
    it 'lets us know if we are touched out' do
      subject.top_up(20)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq false
    end
  end
end
