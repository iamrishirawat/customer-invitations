require_relative '../app/lib/calculations'

describe Calculations do
  class Test
    include Calculations
  end

  before(:all) do
    @test = Test.new
  end

  it 'checks invalid input for convert_degrees_to_radians' do
    expect { @test.convert_degrees_to_radians(nil) }.to output("Incorrect argument passed to method convert_degrees_to_radians: nil\n").to_stdout
  end

  it 'converts degrees to radians' do
    expect(@test.convert_degrees_to_radians(53.2451022)).to eq(0.9293023439508763)
    expect(@test.convert_degrees_to_radians(-6.23972220002785)).to eq(-0.10890369680027019)
  end

  it 'checks invalid input for calculate_great_circle_distance' do
    params1 = { phi1: nil, lambda1: nil, phi2: nil, lambda2: nil }
    expect { @test.calculate_great_circle_distance(**params1) }.to output("Error while calculating great circle distance : undefined method `-' for nil:NilClass\n").to_stdout
  end

  it 'calculates great circle distance' do
    test = Test.new
    params1 = { phi1: 0.90411, lambda1: -0.16479, phi2: 0.9309486, lambda2:-0.1092168 }
    params2 = { phi1: 0.91203826, lambda1: -0.12400377, phi2: 0.9309486, lambda2:-0.1092168 }
    expect(@test.calculate_great_circle_distance(**params1)).to eq(274.81)
    expect(@test.calculate_great_circle_distance(**params2)).to eq(133.26)
  end
end
