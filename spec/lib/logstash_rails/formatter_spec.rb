describe LogstashRails::Formatter do

  subject do
    lambda do |payload|
      LogstashRails::Formatter.get.perform('event', Time.now, Time.now, 1, payload)
    end
  end

  it 'deletes Rack::Request' do
    payload = {request: 'toto'}

    subject.call(payload).should_not include('request')
  end

end
