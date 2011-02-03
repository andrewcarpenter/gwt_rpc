require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GwtRpc::Request do
  before :each do
    GwtRpc::Client.domain "example.com"
    GwtRpc::Client.js_url "http://www.example.com/js"
    @client = GwtRpc::Client.new
    @procedure = GwtRpc::Procedure.new(:namespace => "foo.bar", :method => "hello_you", :path => '/hello', :identifier => "abc")
    @parameters = ["Andrew"]
    @request = GwtRpc::Request.new(@client, :procedure => @procedure, :parameters => @parameters)
  end
  
  describe ".url" do
    it "should be based on the client's domain and the procedure's path" do
      @request.url.should == "http://example.com/hello"
    end
  end
  
  describe ".header" do
    it "should be the GWT version and a flag" do
      @request.header.should == [5,0]
    end
  end
  
  # FIXME: this test knows too much about the implementation :-(
  describe ".data" do
    it "should be the js_url, the identifier, the namespace, the method, the number of parameters, the classes of the parameters, and the serialized parameter values" do
      @request.data.should == [
        @client.js_url,
        @procedure.identifier,
        @procedure.namespace,
        @procedure.method,
        @parameters.size,
        @request.parameter_classes,
        @request.parameter_values
      ].flatten
    end
  end
  
  describe ".body" do
    it "should be the header, the size of the string table, the string table, then the payload, separated by pipes" do
      @request.body.should == "5|0|6|http://www.example.com/js|abc|foo.bar|hello_you|java.lang.String|Andrew|1|2|3|4|1|5|6|"
    end
    
    it "should be the passed body if one is passed" do
      request = GwtRpc::Request.new(@client, :procedure => @procedure, :body => "FOO BAR BAZ")
      request.body.should == "FOO BAR BAZ"
    end
  end
  
  describe ".parameter_classes" do
    it "should return the java class names for each of the parameters passed" do
      @client.class.should_receive(:ruby_class_to_java).with{|klass| klass.should == String}.and_return('java.lang.String')
      @request.parameter_classes.should == ['java.lang.String']
    end
  end
  
  describe ".stringtablize" do
    it "should return the array unchanged if composed only of integers" do
      string_table, vals = @request.stringtablize([1,2,3])
      string_table.should == []
      string_table.should be_empty
      vals.should == [1,2,3]
    end
    
    it "should replace all strings with their location in the string table" do
      string_table, vals = @request.stringtablize([1,"A","A","B",2])
      string_table.should == ["A","B"]
      vals.should == [1,1,1,2,2]
    end
  end
end