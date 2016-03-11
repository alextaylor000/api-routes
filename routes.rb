require 'byebug'


class Client
  attr_accessor :routes

  def initialize
    @routes = {}
  end

  def self.method_missing(name)
    EmptyClass.new(name)
  end

  def print_routes
    @routes.to_s
  end

  class EmptyClass
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def method_missing(name, *args)
      puts "you called #{@name}.#{name}"
    end
  end # EmptyClass
end # Client

@client = Client.new

def namespace(name, &block)
  yield
end

def map_route(route)
  @client.routes[route.to_sym] ||= {}
end

def get(route, options = {})
  map_route(route)
end

def post(route, options = {})
  map_route(route)
end

def delete(route, options = {})
  map_route(route)
end

def print_routes

end

# TODO: how to implement namespace? we want these routes to get stored in the hash structure correctly
#namespace :metrics do
  get 'time-series'      # Client.metrics.time_series
#end

#namespace :transmissions do
  post 'send', as: :send     # Client.transmissions.send(data)
  get  ':id'             # Client.transmissions(id)
  delete ':id'           # Client.transmissions(id).delete
#end


puts @client.print_routes
