require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GwtRpc::Procedure do
  required_options = {:namespace => "java.lang.Greeting", :method => "hello_world", :path => "/hello/world", :identifier => 'abc' }
  
  describe ".new" do
    required_options.keys.each do |key|
      it "should require a #{key}" do
        lambda{GwtRpc::Procedure.new(required_options.except(key))}.should raise_error
      end
    end
    
    it "should succeed when all valid keys are provided" do
      lambda{GwtRpc::Procedure.new(required_options)}.should_not raise_error
    end
  end
  
  describe ".call" do
    it "should return a response" do
      client = GwtRpc::Client.new
      client.domain 'http://www.example.com'
      Typhoeus::Request.should_receive(:post).and_return(Typhoeus::Response.new(:code => 200, :body => "OK//123"))
      GwtRpc::Procedure.new(required_options).call(client).should be_a(GwtRpc::Response)
    end
  end
end