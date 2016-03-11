## sparkpost-api
This is an idea I had for implementing the SparkPost API, or any other API. 

I thought you could define the API endpoints like you do Rails routes, then
generate methods that you can call on the client like:

`client.transmissions.send(data)`

... without having to write a method for each one. This would basically just
find the route in a hash, and put together a request object that sends the 
data through. This might be a really cool way of implementing super-thin wrappers
around APIs.

I'm playing around with the concept in `routes.rb` right now. Just trying to figure
out how to map the routes into a hash, especially how to implement the `namespace` 
method. After that, I'd want to implement a request method that sets headers and
bundles the whole thing into a request (see the ruby-sparkpost gem for an example).

