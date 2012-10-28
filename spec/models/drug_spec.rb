require 'spec_helper'

describe Drug do
  describe 'Drug history' do
    before :each do
      @drug = create :drug, :quantity => 200
      @deltas = []
      @current_time = Time.now
      Time.stub(:now).and_return(@current_time)
      10.times do |i|
        @deltas << create(:drug_deltum, {
          :amount => (-1) ** (i + 1),
          :drug => @drug,
          :timestamp => Time.now - (i + 1) * 1.day
        })
      end
    end

    it 'should fetch the most recent drug deltas for the drug' do
      drug_deltas = @drug.recent_deltas(5.days)
      drug_deltas.length.should == 5
      drug_deltas.to_a.should =~ @deltas[0..4]
    end

    it 'should summarize drug history by computing quantities' do
      @drug.history(5.days).should ==
        [[Time.now.to_i, 200.0],
         [(Time.now - 1.day ).to_i, 201.0],
         [(Time.now - 2.days).to_i, 200.0],
         [(Time.now - 3.days).to_i, 201.0],
         [(Time.now - 4.days).to_i, 200.0],
         [(Time.now - 5.days).to_i, 201.0]]
    end
  end

  it 'should aggregate quantity data' do
    drug = create :drug
    drug.should_receive(:history).
      and_return([[1351412553, 10], [1351326153, 20], [1351153353, 30], [1351066954, 20]])

    drug.time_aggregated_data(1.week, 3.days).should ==
      [[1351209600, 15], [1350950400, 25]]
  end
end
