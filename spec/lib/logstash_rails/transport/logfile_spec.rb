describe LogstashRails::Transport::Logfile do

  let :logfile do
    Tempfile.new(File.basename(__FILE__))
  end

  subject do
    formatter = LogstashRails::Formatter.get
    LogstashRails::Transport::Logfile.new(formatter, logfile: logfile)
  end

  it { should respond_to :push }

  it 'writes events to a logfile' do
    event = 'foobar_event'

    subject.push(event)

    logfile.rewind
    expect(logfile.read).to include(event)
  end

end
