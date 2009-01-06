require 'rubygems'
require 'amqp'
require 'mq'
require 'pp'

EM.run do
  AMQP.start(:user  => 'nanite',
             :pass  => 'testing',
             :vhost => '/nanite',
             :host  => '127.0.0.1',
             :port  => AMQP::PORT)

  EM.next_tick do
    amq = MQ.new
    amq.queue("one").subscribe do |msg|
      puts "Got msg for #{$$}"
      data = Marshal.load(msg)
      pp data
    end
  end

  puts "Waiting @ #{Time.now.to_f}"
end
