require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::Gxt::Hash do
  describe ".new" do
    it "should be a subclass of Hash" do
      GwtRpc::Gxt::Hash.new should be_a(Hash)
    end
  end
  describe ".gwt_deserialize" do
    before :each do
      @client = GwtRpc::Client.new
      @reader = GwtRpc::Response::Reader.new(@client, '[5,2,4,3,2,1,2,["Hello","java.lang.String/2004016611","Hola","Goodbye","Adios"],0,5]')
    end
    
    it "should determine it size and call read_object that many times" do
      GwtRpc::Gxt::Hash.gwt_deserialize(@reader).should == GwtRpc::Gxt::Hash['Hello' => 'Hola', 'Goodbye' => 'Adios']
    end
  end
end