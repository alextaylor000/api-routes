## sparkpost-api
This is an idea I had for implementing the SparkPost API, or any other API. 

I thought you could define the API endpoints like you do Rails routes, then
generate methods that you can call on the client like:

`client.transmissions.send(data)`

... without having to write a method for each one. This would basically just
find the route in a hash, and put together a request object that sends the 
data through. This might be a really cool way of implementing super-thin wrappers
around APIs.

Got the routes kind of working, right now you can call stuff like @client.transmissions(5).get
and it will work.  Need to figure out if this is the best way. 
