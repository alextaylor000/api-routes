require 'byebug'

class Symbol
  # Convert a symbol into a string which can be used as a class name.
  def constantize
    self.to_s.capitalize
  end
end

class Client
  @@parent = nil

  def self.parent
    @@parent
  end

  def self.create_class(name, &block)
    # create a new class based on the name. e.g. if `name` is 
    # :transmissions, this will create a new Transmissions class
    # that can be instantiated with an optional id.
    klass = Class.new do
      Object.const_set(name.constantize, self)

      define_method :initialize do |id = nil|
        @id = id
      end

      define_method :id do
        @id
      end

      define_method :create_method do |args|
        byebug
      end
    end

    # create an accessor method on client, e.g. client.transmissions(5)
    define_method name do |id = nil|
      klass.new(id)
    end

    klass
  end

  def self.resource(name, &block)
    klass = create_class(name, &block)
    klass.instance_eval(&block)
  end

end

# creates a method on a resource class which returns a payload.
# this method is run from the context of a resource class, e.g.
# from Transmissions, using instance_eval
def endpoint(*args)
  name, opts = args
  define_method name do |data = {}|
    {
      url: url_gen(opts[:url], @id),
      method: opts[:method],
      data: data
    }
  end
end

def url_gen(str, id)
  str.gsub(':id', id.to_s)
end

### test interface:
Client.resource :transmissions do
  endpoint :create, url: '/', method: :post
  endpoint :get, url: '/:id', method: :get
end
