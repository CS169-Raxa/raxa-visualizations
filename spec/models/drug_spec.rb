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
        [{:date => Time.now.to_i, :count => 200.0},
        {:date => (Time.now - 1.day ).to_i, :count => 201.0},
        {:date => (Time.now - 2.days).to_i, :count => 200.0},
        {:date => (Time.now - 3.days).to_i, :count => 201.0},
        {:date => (Time.now - 4.days).to_i, :count => 200.0},
        {:date => (Time.now - 5.days).to_i, :count => 201.0}]
    end
  end

  it 'should aggregate quantity data' do
    drug = create :drug
    drug.should_receive(:history).
      and_return([{ :date => 1351412553, :count => 10 },
                   { :date => 1351326153, :count => 20 },
                   { :date => 1351153353, :count => 30 },
                   { :date => 1351066954, :count => 20 }])

    drug.time_aggregated_data(1.week, 3.days).should ==
      [{ :date => 1351209600, :count => 15 }, { :date => 1350950400, :count => 25 }]
  end

  it 'should gracefully not aggregate quantity data if none available' do
    drug = create :drug
    drug.should_receive(:history).and_return(false)

    drug.time_aggregated_data(1.week, 3.days).should be false
  end
end
