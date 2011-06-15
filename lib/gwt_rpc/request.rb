class GwtRpc::Request
  def initialize(client, options = {})
    @client = client
    @procedure = options[:procedure]
    @parameters = options[:parameters]
    @body = options[:body]
  end
  
  def call
    10.times do
      begin
        response = Typhoeus::Request.post(url,
              :body          => body,
              :headers       => {
                'Content-Type' => "text/x-gwt-rpc; charset=utf-8",
                'X-GWT-Module-Base' => @client.js_url,
                'X-GWT-Permutation' => @client.gwt_permutation,
              },
              :timeout       => 1000,
              :cache_timeout => 60)
        return GwtRpc::Response.new(@client, response).content
      rescue GwtRpc::Error::NoResponse
        # prevent random hiccups
      end
    end
  end
  
  def url
    'http://' + @client.domain + @procedure.path
  end
  
  def header
    [5,0]
  end
  
  def body
    if @body
      body = @body
    else
      string_table, payload = stringtablize(data)
      body = (header + [string_table.size] + string_table + payload).join("|")  + "|"
    end
  end
  
  def data
    [
      @client.js_url,
      @procedure.identifier,
      @procedure.namespace,
      @procedure.method,
      @parameters.size,
      parameter_classes,
      parameter_values.flatten
    ].flatten
  end
  
  def parameter_classes
    @parameters.map{|p| @client.class.ruby_class_to_java(p.class)}
  end
  
  def parameter_values
    @parameters.map{|p| p.gwt_serialize }.flatten
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