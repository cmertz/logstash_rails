describe LogstashRails::Formatter::Source do

  subject do
    lambda do |payload|
      LogstashRails::Formatter.get(source: 'test').perform('event', Time.now, Time.now, 1, payload)
    end
  end

  it 'knows its source' do
    result = subject.call({})
    JSON.parse(result).should include({'source' => 'test'})
  end

end
