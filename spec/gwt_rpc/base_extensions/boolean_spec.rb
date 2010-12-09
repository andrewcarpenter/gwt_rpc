require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::BaseExtensions::Boolean do
  describe ".gwt_deserialize" do
    it "0 should be false" do
      client = GwtRpc::Client.new
      reader = GwtRpc::Response::Reader.new(client, '[0,[],0,5]')
      GwtRpc::BaseExtensions::Boolean.gwt_deserialize(reader).should == false
    end
    it "1 should be true" do
      client = GwtRpc::Client.new
      reader = GwtRpc::Response::Reader.new(client, '[0,[],0,5]')
      GwtRpc::BaseExtensions::Boolean.gwt_deserialize(reader).should == false
    end
  end
end