class GwtRpc::Request
  def initialize(client, procedure, *parameters)
    @client = client
    @procedure = procedure
    @parameters = parameters.to_a
  end
  
  def call
    response = Typhoeus::Request.post(url,
          :body          => body,
          :headers       => {'Content-Type' => "text/x-gwt-rpc; charset=utf-8"},
          :timeout       => 1000,
          :cache_timeout => 60)
    GwtRpc::Response.new(@procedure, @client, response).content
  end
  
  def url
    'http://' + @client.domain + @procedure.path
  end
  
  def header
    [5,0]
  end
  
  def body
    string_table, payload = stringtablize(data)
    (header + [string_table.size] + string_table + payload).join("|")  + "|"
  end
  
  def data
    [
      @client.js_url,
      @procedure.identifier,
      @procedure.namespace,
      @procedure.method,
      @parameters.size,
      parameter_classes,
      parameter_values
    ].flatten
  end
  
  def parameter_classes
    @parameters.map{|p| @client.class.ruby_class_to_java(p.class)}
  end
  
  def parameter_values
    @parameters.map{|p| p.class.gwt_serialize(p) }
  end
  
  def stringtablize(data)
    string_table = data.select{|v| v.class == String }.uniq
    vals = data.map do |v|
      if v.class == String
        string_table.index(v) + 1
      else
        v
      end
    end
    return string_table, vals
  end
end