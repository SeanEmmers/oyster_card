require 'oystercard'

describe Oystercard do
  it 'has an initialized balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up the balance' do
      top_up_balance = 10
      expect(subject.top_up(top_up_balance)).to eq top_up_balance
    end
  end

end
