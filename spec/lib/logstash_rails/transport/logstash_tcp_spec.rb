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
    expect(logstash_tcp).to respond_to :push
  end

  it 'uses Celluliod::IO if present' do
    celluloid = double(:celluloid, new: double(:socket, close: nil, write: nil))
    stub_const('Celluloid::IO::TCPSocket', celluloid)

    expect(celluloid).to receive(:new)

    logstash_tcp.push 'toto'

    logstash_tcp.destroy
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
    expect(@received).to eq 'toto'
  end

  it 'lazily connects the socket' do
    expect{ logstash_tcp.push 'toto' }.to change{
      logstash_tcp.instance_variable_get(:@socket).class
    }
  end

end
