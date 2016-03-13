#resource :transmissions do
#  endpoint :create, url: '/', method: :post
#  endpoint :get, url: '/:id', method: :get
#end

class Transmissions
  attr_reader :id

  def initialize(id=nil)
    @id = id
  end


  #def create(data={})
  #  payload('/transmissions/', :post, data)
  #end

  def get(data={})
    payload('/transmissions/#{@id}', :get, data)
  end
end

def transmissions(id=nil)
  Transmissions.new(id)
end

class Resource
  attr_reader :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def payload(url, method, data)
    {
      url: url,
      method: method,
      data: data
    }
  end
end

# dynamically create a method:
def create_endpoint_method(resource, name, url, method)
  Resource.class_eval(%{
    def #{resource}_#{name}(data={})
      url = ['#{resource}', '#{url}'].join("/").gsub(':id',@id.to_s) 
      puts url
    end
  }, __FILE__, __LINE__)
end


#payload = r.create({a: 3, b: 2})
#puts payload.to_s
create_endpoint_method('transmissions', 'create', '/:id', 'post')
payload = Resource.new(:transmissions, 567).transmissions_create({a: 2})
puts payload.to_s
