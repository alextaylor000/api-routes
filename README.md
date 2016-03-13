## api-routes
This is an idea I had for implementing the SparkPost API, or any other API. 

I thought you could define the API endpoints like you do Rails routes, then
generate methods that you can call on the client. 

You could set it up something like this:

```
resource :transmissions do
  endpoint :create, url: '/', method: :post
  endpoint :get, url: '/:id', method: :get
end
```

... and then use it like this:

`client.transmissions.send(data)`

`client.transmissions(645).get`

... without having to write a method for each one. This would put together a request object that sends the 
data through, with the correct API key etc, and returns whatever the API gives back.. This might be a really cool way of implementing super-thin wrappers
around APIs.

There's a demo in example.rb that proves the concept, but I need some help figuring out the
best way to make a clean public interface for the DSL.
