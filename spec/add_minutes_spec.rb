# frozen_string_literal: true

require './add_minutes.rb'

describe 'convert_to_military_time' do
  context "given '9:23 AM'" do
    it "returns '9:13'" do
      expect(convert_to_military_time('9:13 AM')).to eq('9:13')
    end
  end

  context "given '2:13 PM'" do
    it "returns '14:13'" do
      expect(convert_to_military_time('2:13 PM')).to eq('14:13')
    end
  end
end

describe 'convert_to_american_time' do
  context "given '9:13'" do
    it "returns '9:13 AM'" do
      expect(convert_to_american_time('9:13')).to eq('9:13 AM')
    end
  end

  context "given '14:13'" do
    it "returns '2:13 PM'" do
      expect(convert_to_american_time('14:13')).to eq('2:13 PM')
    end
  end
end

describe 'add_minutes' do
  context 'given a positive number of minutes' do
    it 'will add those minutes to the given time' do
      expect(add_minutes('9:13 AM', 200)).to eq('12:33 PM')
    end
  end

  context 'given a negative number of minutes' do
    it 'will substract those minutes to the given time' do
      expect(add_minutes('2:13 PM', -200)).to eq('11:53 AM')
    end
  end

  # 720 minutes is 12 hours
  # 1440 minutes is 24 hours
  # 600 minutes is 10 hours
  context 'given number of minutes exceeds the day' do
    it 'will roll over the minutes and give the time of the next day' do
      expect(add_minutes('2:13 PM', 720)).to eq('2:13 AM')
      expect(add_minutes('9:13 AM', 1440)).to eq('9:13 AM')
      expect(add_minutes('9:13 AM', -600)).to eq('11:13 PM')
    end
  end
end
