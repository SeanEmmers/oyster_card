require 'oystercard'

describe Oystercard do
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:oyster_card) {Oystercard.new}

  context 'When the card has already been topped up & /
    touched in' do
    before(:each) do
      oyster_card.top_up(90)
      oyster_card.touch_in(entry_station)
    end
    it 'and it stores a journey' do
      oyster_card.touch_out(exit_station)
      expect(oyster_card.journey_list).to include journey
    end     
     
    describe '#touch_out' do
      it 'deducts a minimum fare when touching out' do 
        minimum_fare = Oystercard::MINIMUM_FARE - Oystercard::MINIMUM_FARE*2
        expect { oyster_card.touch_out(exit_station) }.to change{ oyster_card.balance }.by(minimum_fare)
      end
    end
  end

  describe '#initialize' do
    it 'has an initialized balance of 0' do
      starting_balance = Oystercard::STARTING_BALANCE
      expect(subject.balance).to eq starting_balance
    end
    it 'has an empty journey list to begin' do
      expect(subject.journey_list).to be_empty
    end
  end

  describe '#top_up' do
    it 'tops up the balance' do
      subject.top_up(20)
      expect(subject.balance).to eq 20
    end
    it 'does not exceed top up of 90' do
      expect{ subject.top_up(Oystercard::MAXIMUM_BALANCE + 1) }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
    end
  end

  describe '#touch_in' do
    it 'raises an error if there are not enough funds to touch in' do
      minimum_fare = Oystercard::MINIMUM_FARE
      expect{ subject.touch_in(entry_station) }.to raise_error "You don't have the minimum balance £#{minimum_fare} to touch on"
    end
  end
end