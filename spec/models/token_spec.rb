require_relative '../../app/models/token.rb'

describe Token do

  subject (:token) {described_class.new}

  describe '#token characteristics' do

    before do
      Timecop.freeze
    end

    it 'has an initial time stamp' do
      expect(token.time_start).to eq Time.now
    end
  end

end
