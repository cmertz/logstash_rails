describe LogstashRails::Transport::LogstashUdp do
  subject do
    LogstashRails::Transport::LogstashUdp.new
  end

  it { should respond_to :push }
end
