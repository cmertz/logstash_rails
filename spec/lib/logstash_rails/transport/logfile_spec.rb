describe LogstashRails::Transport::Logfile do

  let :logfile do
    Tempfile.new(__FILE__)
  end

  subject do
    LogstashRails::Transport::Logfile.new(logfile: logfile)
  end

  it { should respond_to :push }

  it 'writes events to a logfile' do
    event = 'foobar_event'

    subject.push(event)

    logfile.rewind
    logfile.read.should include(event)
  end

end
