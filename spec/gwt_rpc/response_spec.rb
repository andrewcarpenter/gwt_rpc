require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GwtRpc::Response do
  before :each do
    @client = GwtRpc::Client.new
  end
  
  describe ".new" do
    it "should return a response object when everything is ok" do
      response = Typhoeus::Response.new(:code => 200, :body => "//OK[1,2,3,4]")
      GwtRpc::Response.new(nil, @client, response).should be_a(GwtRpc::Response)
    end
    
    it "should raise an error when the response is not a 200" do
      response = Typhoeus::Response.new(:code => 500)
      lambda { GwtRpc::Response.new(nil, @client, response) }.should raise_error GwtRpc::Error::ServerError
    end
    
    it "should raise an error when there is no response" do
      response = Typhoeus::Response.new(:code => 0)
      lambda { GwtRpc::Response.new(nil, @client, response) }.should raise_error GwtRpc::Error::NoResponse
    end
    
    it "should raise an error when the response body does not begin with //OK" do
      response = Typhoeus::Response.new(:code => 200, :body => "//ERR")
      lambda { GwtRpc::Response.new(nil, @client, response) }.should raise_error GwtRpc::Error::ServerError
    end
  end
  
  # describe ".content" do
  #   it "should call GwtRpc::ResponseReader" do
  #     response = Typhoeus::Response.new(:code => 200, :body => "//OK[1,2,3,4]")
  #     @client = GwtRpc::Client.new
  #     
  #     GwtRpc::Response::Reader.should_receive(:new).with(@client,'[1,2,3,4]')
  #     GwtRpc::Response.new(nil, @client, response).content
  #   end
  # end
end