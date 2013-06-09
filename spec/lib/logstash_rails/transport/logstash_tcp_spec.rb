describe LogstashRails::Transport::LogstashTcp do
  subject do
    LogstashRails::Transport::LogstashTcp.new(port: 10000)
  end

  it { should respond_to :push }
end
