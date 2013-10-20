describe LogstashRails::Formatter::Basic do

  subject do
    LogstashRails::Formatter.get.perform('event', Time.now, Time.now, 1, {request: 'toto'})
  end

  it 'deletes Rack::Request' do
    subject.should_not include('request')
  end

  %w(message host process_id source).each do |field|
    it "adds #{field}" do
      subject.should include(field)
    end
  end

  it 'has the event type as message' do
    JSON.parse(subject)["message"].should eq 'event'
  end

end
