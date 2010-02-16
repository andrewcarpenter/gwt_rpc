require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::BaseExtensions::String do
  describe ".gwt_serialize" do
    it "shpuld return itself" do
      "foo".gwt_serialize.should == "foo"
    end
  end
end