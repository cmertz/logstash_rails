describe LogstashRails::Transport::LogstashTcp do

  before do
    @server = TCPServer.new(9000)

    @thread = Thread.new do
      client = @server.accept
      @received = client.gets
      client.close
    end
  end

  after do
    @thread.kill
    @server.close
  end

  let :logstash_tcp do
    formatter = LogstashRails::Formatter.get
    LogstashRails::Transport::LogstashTcp.new(formatter, port: 9000)
  end

  it do
    logstash_tcp.should respond_to :push
  end

  it 'should close the tcp socket' do
    # initialize tcp socket
    logstash_tcp.push 'toto'

    socket = logstash_tcp.instance_variable_get(:@socket)
    expect{ logstash_tcp.destroy }.to change{ socket.closed? }.from(false).to(true)
  end

  it 'sends data over tcp' do
    logstash_tcp.push 'toto'
    logstash_tcp.destroy
    @thread.join
    @received.should eq 'toto'
  end

  it 'lazily connects the socket' do
    expect{ logstash_tcp.push 'toto' }.to change{
      logstash_tcp.instance_variable_get(:@socket).class
    }
  end

end
