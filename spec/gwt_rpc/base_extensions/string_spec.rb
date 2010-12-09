require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::BaseExtensions::String do
  describe ".gwt_serialize" do
    it "should return itself" do
      String.gwt_serialize("foo").should == "foo"
    end
  end
  
  describe ".gwt_deserialize" do
    it "should simply read a string from the string table" do
      client = GwtRpc::Client.new
      reader = GwtRpc::Response::Reader.new(client, '[1,["foo"],0,5]')
      
      String.gwt_deserialize(reader).should == "foo"
    end
  end
end