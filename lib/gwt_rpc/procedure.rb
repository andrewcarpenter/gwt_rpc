class GwtRpc::Procedure
  attr_reader :path, :namespace, :method, :identifier
  def initialize(options, &block)
    options.symbolize_keys!
    @path = options[:path] or raise ":path must be provided"
    if block
      @block = block
    else
      @namespace = options[:namespace] or raise ":namespace must be provided"
      @method = options[:method] or raise ":method must be provided"
      @identifier = options[:identifier] or raise ":identifier must be provided"
    end
  end
  
  def call(client, *parameters)
    response = request(client, *parameters).call
  end
  
  def request(client, *parameters)
    if @block
      GwtRpc::Request.new(client, :procedure => self, :body => @block.call(*parameters))
    else
      GwtRpc::Request.new(client, :procedure => self, :parameters => parameters)
    end
  end
end