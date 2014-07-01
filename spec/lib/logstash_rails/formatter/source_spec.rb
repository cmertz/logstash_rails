describe LogstashRails::Formatter::Source do

  subject do
    lambda do |options, payload|
      LogstashRails::Formatter.get(options).perform('event', Time.now, Time.now, 1, payload)
    end
  end

  it 'knows its source' do
    result = subject.call({source: 'test'}, {})
    expect(JSON.parse(result)).to include({'source' => 'test'})
  end

  it 'can be disabled' do
    result = subject.call({source: false}, {})
    expect(JSON.parse(result).keys).to_not include('source')
  end

end
