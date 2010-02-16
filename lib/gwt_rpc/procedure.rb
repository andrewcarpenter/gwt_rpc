class GwtRpc::Procedure
  attr_reader :path, :namespace, :method, :identifier
  def initialize(options)
    options.symbolize_keys!
    @path = options[:path] or raise ":path must be provided"
    @namespace = options[:namespace] or raise ":namespace must be provided"
    @method = options[:method] or raise ":method must be provided"
    @identifier = options[:identifier] or raise ":identifier must be provided"
  end
  
  def call(client, parameters = [])
    request = GwtRpc::Request.new(client, self, parameters)
    response = request.call
    # response.deserialize
  end
end