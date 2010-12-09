require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::BaseExtensions::Array do
  describe ".gwt_deserialize" do
    before :each do
      @client = GwtRpc::Client.new
      @reader = GwtRpc::Response::Reader.new(@client, '[3,1,2,1,2,["java.lang.String/2004016611","Hello","World"],0,5]')
    end
    
    it "should determine it size and call read_object that many times" do
      Array.gwt_deserialize(@reader).should == ['Hello', 'World']
    end
  end
end