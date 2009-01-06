require 'rubygems'
require 'amqp'
require 'mq'

EM.run do
  AMQP.start(:user  => 'nanite',
             :pass  => 'testing',
             :vhost => '/nanite',
             :host  => '127.0.0.1',
             :port  => AMQP::PORT)

  amq = MQ.new
  amq.queue("one", :exclusive => true).subscribe do |msg|
    puts "Got a message"
    puts msg
  end
end
