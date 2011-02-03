require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::BaseExtensions::MultipartString do
  describe ".gwt_deserialize" do
    it "should combine multiple strings" do
      client = GwtRpc::Client.new
      reader = GwtRpc::Response::Reader.new(client, '[3,2,1,3,["a","b","c"],0,5]')
      GwtRpc::BaseExtensions::MultipartString.gwt_deserialize(reader).should == ["a","b","c"]
    end
  end
end