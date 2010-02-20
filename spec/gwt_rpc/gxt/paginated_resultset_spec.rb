require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::Gxt::PaginatedResultset do
  describe ".gwt_deserialize" do
    it "should parse correctly" do
      @client = GwtRpc::Client.new
      @reader = GwtRpc::Response::Reader.new(@client, '[3,2,1,1,1,0,["java.util.ArrayList","java.lang.String","Hi"],0,5]')
      results = GwtRpc::Gxt::PaginatedResultset.gwt_deserialize(@reader)
      results.offset.should == 0
      results.total_count.should == 1
      results.results.should == ['Hi']
    end
  end
end