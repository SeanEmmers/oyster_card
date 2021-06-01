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
      expect{ subject.top_up(100) }.to raise_error 'Balance cannot exceed 90'
    end
  end
end
