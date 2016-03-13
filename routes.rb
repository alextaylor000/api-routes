require 'byebug'


class Client
  attr_accessor :routes

  def initialize
    @routes = {}
  end

  def method_missing(*args)
    route_name = args.shift
    id = args[0] if args[0].is_a?(Fixnum)
    EmptyClass.new(route_name, id, @routes)
  end

  def print_routes
    @routes.to_s
  end

  class EmptyClass
    attr_reader :name
    attr_reader :id
    attr_reader :routes

    def initialize(name, id=nil, routes)
      @name = name
      @id = id
      @routes = routes
    end

    def method_missing(name, *args)
      endpoint = @routes[@name][name]
      real_url = [@name, @id, name].delete_if(&:nil?).join("/")
      {url: real_url, method: endpoint[:method]}
    end
  end # EmptyClass
end # Client

@client = Client.new
@scope = nil

def namespace(name, &block)
  @scope = name.to_s
  yield
  @scope = nil
end

def map_route(route, resource=nil, method, orig_route)
  qualified_scope = @scope
  if @scope
    @client.routes[qualified_scope.to_sym] ||= {}
    @client.routes[qualified_scope.to_sym][route.to_sym] ||= {url: orig_route, method: method}
  else
    @client.routes[route.to_sym] ||= {url: orig_route, method: method}
  end
end

def get(route, options = {})
  resource = true if route == ':id'
  name = options[:as] || route
  map_route(name, resource, 'get', route)
end

def post(route, options = {})
  resource = true if route == ':id'
  name = options[:as] || route
  map_route(name, resource, 'post', route)
end

def delete(route, options = {})
  resource = true if route == ':id'
  name = options[:as] || route
  map_route(name, resource, 'delete', route)
end

def print_routes

end

namespace :metrics do
  get 'time-series'          # => Client.metrics.time_series => /metrics/time-series
end

namespace :transmissions do
  post '', as: :create       # => Client.transmissions.create => /transmissions/
  get  ':id', as: :get       # => Client.transmissions(id).get => /transmissions/:id
  delete ':id', as: :delete  # => Client.transmissions(id).delete => /transmissions/:id
end


puts @client.print_routes
