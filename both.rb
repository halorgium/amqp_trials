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
    # Setup some listeners
    10.times do |i|
      amq = MQ.new
      amq.queue("one").subscribe do |msg|
        puts "Got msg on listener #{i}"
        data = Marshal.load(msg)
        pp data
      end
    end

    1000.times do |i|
      data = ["hello #{i}", Time.now.to_f]
      amq = MQ.new
      amq.queue("one").publish(Marshal.dump(data))
    end
  end

  puts "Waiting @ #{Time.now.to_f}"
end
