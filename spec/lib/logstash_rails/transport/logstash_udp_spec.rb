describe LogstashRails::Transport::LogstashUdp do

  subject do
    formatter = LogstashRails::Formatter.get
    LogstashRails::Transport::LogstashUdp.new(formatter, port: 9001)
  end

  it { should respond_to :push }

  it 'sends data over udp' do
    message = "toto"
    socket = UDPSocket.new
    socket.bind('127.0.0.1', 9001)

    received = nil
    thread = Thread.new do
      received = socket.recvfrom(message.length).first
    end

    subject.push message

    thread.join
    socket.close

    received.should eq message
  end

end
