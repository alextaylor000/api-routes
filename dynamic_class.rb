class Symbol
  # Convert a symbol into a string which can be used as a class name.
  def constantize
    self.to_s.capitalize
  end
end

class Client
  def self.create_class(name)
    klass = Class.new do
      Object.const_set(name.constantize, self)

      define_method :initialize do |id = nil|
        @id = id
      end

      define_method :id do
        @id
      end
    end
    klass
  end

  def self.resource(name)
    create_class(name)
  end
end
