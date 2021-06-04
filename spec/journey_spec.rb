require 'journey'
describe Journey do

  let(:station) { double :station, zone: 1 }
  let(:other_station) { double :other_station, zone: 3 }
  describe '#finish' do
    it 'returns fare if they have not completed a journey' do
      expect(subject.finish).to eq subject.fare
    end
    it 'turns complete true if a journey has been completed' do
      subject.entry_station = station
      subject.exit_station(other_station)
      subject.finish
      expect(subject.complete).to eq true
    end
  end
  
  it "knows if a journey is not complete" do
    expect(subject.complete?).to eq false
  end
  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end
  
  context 'given an entry station' do
    subject {described_class.new(station)}
    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end
    it "returns a penalty fare if no exit station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      before do
        subject.finish
      end
      it 'calculates a fare' do
        expect(subject.fare).to eq 6
      end
    end
  end
end














