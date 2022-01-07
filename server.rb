#!/usr/bin/env ruby
require 'bunny'

class Server
  FILENAME = 'test.csv'

  def initialize
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel
  end

  def start(queue_name)
    @queue = channel.queue(queue_name)
    @exchange = channel.default_exchange
    @channel.queue('reply_queue')
    subscribe_to_queue
  end

  def stop
    channel.close
    connection.close
  end

  def loop_forever
    loop { sleep 5 }
  end

  private

  attr_reader :channel, :exchange, :queue, :connection

  def subscribe_to_queue
    queue.subscribe do |_delivery_info, properties, payload|

      puts "got call with #{properties} /n #{payload}"
      exchange.publish(
        result.to_s,
        routing_key: properties.reply_to
      )
    end
  end

  def result
    return text = File.read('test.csv')
  end
end

begin
  server = Server.new

  puts ' [x] Awaiting RPC requests'
  server.start('rpc_queue')
  server.loop_forever
rescue Interrupt => _
  server.stop
end