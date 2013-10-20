describe LogstashRails::Formatter::Source do

  subject do
    lambda do |options, payload|
      LogstashRails::Formatter.get(options).perform('event', Time.now, Time.now, 1, payload)
    end
  end

  it 'knows its source' do
    result = subject.call({source: 'test'}, {})
    JSON.parse(result).should include({'source' => 'test'})
  end

  it 'can be disabled' do
    result = subject.call({source: false}, {})
    JSON.parse(result).keys.should_not include('source')
  end

end
