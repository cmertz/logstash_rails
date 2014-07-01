describe LogstashRails::Formatter::Basic do

  subject do
    LogstashRails::Formatter.get.perform('event', Time.now, Time.now, 1, {request: 'toto'})
  end

  it 'deletes Rack::Request' do
    expect(subject).not_to include('request')
  end

  %w(message host process_id source).each do |field|
    it "adds #{field}" do
      expect(subject).to include(field)
    end
  end

  it 'has the event type as message' do
    expect(JSON.parse(subject)["message"]).to eq 'event'
  end

end
