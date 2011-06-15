class GwtRpc::Error < Exception; end
class GwtRpc::Error::ServerError < GwtRpc::Error; end
class GwtRpc::Error::NoResponse < GwtRpc::Error; end

class GwtRpc::Response
  def initialize(client, raw_response)
    @client       = client
    @raw_response = raw_response
    
    raise GwtRpc::Error::NoResponse.new("Error: no response to request") if @raw_response.code == 0
    raise GwtRpc::Error::ServerError.new("Error: status code #{@raw_response.code} not 200; body is #{@raw_response.body}") if @raw_response.code != 200
    raise GwtRpc::Error::ServerError.new("Error: #{@raw_response.body}") if @raw_response.body !~ /^\/\/OK/
  end
  
  def content
    json_body = @raw_response.body.sub(/^\/\/OK/,'')
    GwtRpc::Response::Reader.new(@client, json_body).read_object
  end
end
