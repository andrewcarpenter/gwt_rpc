require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::Gxt::SortInfo do
  describe ".gwt_deserialize" do
    it "should determine it size and call read_object that many times" do
      @client = GwtRpc::Client.new
      @reader = GwtRpc::Response::Reader.new(@client, '[0,0,0,1,["com.extjs.gxt.ui.client.Style$SortDir/640452531"],0,5]')
      sort_info = GwtRpc::Gxt::SortInfo.gwt_deserialize(@reader)
      sort_info.field.should == nil
      sort_info.direction.direction.should == 0
    end
  end
end