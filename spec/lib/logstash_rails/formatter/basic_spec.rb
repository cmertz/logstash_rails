describe LogstashRails::Formatter::Basic do

  subject do
      LogstashRails::Formatter.get.perform('event', Time.now, Time.now, 1, {request: 'toto'})
  end

  it 'deletes Rack::Request' do
    subject.should_not include('request')
  end

  [:process_id, :host, :message].each do |field|
    it "adds #{field}" do
      subject.should include(field.to_s)
    end
  end

end
