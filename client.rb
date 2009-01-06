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
    10.times do |i|
      data = ["hello #{i}", Time.now.to_f]
      puts "Sending data: "
      pp data
      amq.queue("one").publish(Marshal.dump(data))
    end
  end

  puts "Waiting @ #{Time.now.to_f}"
end
