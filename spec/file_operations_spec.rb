require_relative '../app/lib/file_operations'

describe FileOperations do
  class Test
    include FileOperations
  end

  before(:all) do
    @test = Test.new
  end

  it 'checks invalid url' do
    expect { @test.import_data_list('xyz') }.to output("Error while processing file. Error: No such file or directory @ rb_sysopen - xyz\n").to_stdout
  end

  it 'imports data' do
    expect(@test.import_data_list('https://s3.amazonaws.com/intercom-take-home-test/customers.txt').class).to eq(Array)
  end

  it 'checks argument error' do
    expect { @test.export_data_list('test.txt') }.to raise_error(ArgumentError)
  end

  it 'checks invalid data' do
    expect { @test.export_data_list('test.txt', 123) }.to output("Can't save file. Error: undefined method `each' for 123:Integer\n").to_stdout
  end

  it 'checks invalid data' do
    expect(@test.export_data_list('test.txt', [123])).to eq([123])
  end

  after(:all) do
    File.delete('test.txt') if File.exists? 'test.txt'
  end
end
