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
  amq.queue("one").publish("hello")
end
