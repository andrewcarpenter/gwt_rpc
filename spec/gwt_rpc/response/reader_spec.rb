require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GwtRpc::Response::Reader do
  before :each do
    client = GwtRpc::Client.new
    @reader = GwtRpc::Response::Reader.new(client, '[4,2,3,2,2,1,["java.util.ArrayList/3821976829","java.lang.String/2004016611","Hello","World"],0,5]')
  end
  
  describe ".string_table" do
    it "should be all the provided strings" do
      @reader.string_table.should == ["java.util.ArrayList/3821976829","java.lang.String/2004016611","Hello","World"]
    end
  end
  
  describe ".version" do
    it "should be the last value" do
      @reader.version.should == 5
    end
  end
  
  describe ".data" do
    it "should be the integer payload in reverse order" do
      @reader.data.should == [1,2,2,3,2,4]
    end
  end
  
  describe ".read_int" do
    it "should read the first value off the data stack" do
      @reader.read_int.should == 1
      @reader.data == [2,2,3,2,4]
    end
  end
  
  describe ".read_string" do
    it "should read the first value off the stack with no parameters" do
      @reader.read_string.should == "java.util.ArrayList/3821976829"
    end
    
    it "should read the specified string when value provided" do
      @reader.read_string(1).should == "java.util.ArrayList/3821976829"
      @reader.read_string(2).should == "java.lang.String/2004016611"
    end
    
    it "should error when reading a specified string beyond the maximum seen" do
      lambda { @reader.read_string(4) }.should raise_error
    end
  end
  describe ".read_object" do
    it "should call .gwt_deserialize on the appropriate class" do
      Array.should_receive(:gwt_deserialize)
      @reader.read_object
    end
    it "should return the extracted data structure"# do
    #   @reader.read_object.should == ["Hello", "World"]
    # end
  end
end