# stomp-rabbitmq-example

# Steps to run
1) Install and Make sure you have rabbitmq running
2) `gem install bunny`
3) enable rabbitmq plugin `rabbitmq-plugins enable rabbitmq_web_stomp`
4) start file_server by `ruby server.rb`
5) open js_stomp.html in browser and wait for approx 5 second to see the popup with response.

# How this works:
1) ruby script (server.rb) subscribes to `rpc_queue` queue and waits
2) html page (js_stomp.html) when opened in browser sends message to `rpc_queue` queue. with `reply-to` header containing reply channel name
3) html page then and subscribes to that `reply-to` channel and waits to receive a file.
3) ruby script server gets the message and responds with file (test.csv) as a string on channel specified in `reply-to` header.
4) html page receives the message and shows the alert box with all message details.

# Default config used:
Endpoint: `ws://localhost:15674/ws`
login: `guest` 
passcode: `guest`
