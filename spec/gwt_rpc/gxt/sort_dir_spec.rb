require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::Gxt::SortDir do
  describe ".gwt_deserialize" do
    it "should determine the direction" do
      @client = GwtRpc::Client.new
      @reader = GwtRpc::Response::Reader.new(@client, '[1,[],0,5]')
      GwtRpc::Gxt::SortDir.gwt_deserialize(@reader).direction == 1
    end
  end
end