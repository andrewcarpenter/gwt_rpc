require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GwtRpc::Client do
  before :each do
    @subclass = Class.new(GwtRpc::Client)
  end
  describe ".domain" do
    it "should set the domain when passed a value" do
      @subclass.domain "example.com"
      @subclass.domain.should == "example.com"
    end
  end
  
  describe ".js_url" do
    it "should set the js_url when passed a value" do
      @subclass.js_url "http://www.example.com/foo/bar/"
      @subclass.js_url.should == "http://www.example.com/foo/bar/"
    end
  end
  
  describe "default class mapping" do
    it "should define string" do
      @subclass.java_class_to_ruby("java.lang.String").should == "String"
      @subclass.java_class_to_ruby("java.util.ArrayList").should == "Array"
      @subclass.java_class_to_ruby("java.util.HashMap").should == "Hash"
      @subclass.java_class_to_ruby("java.lang.Boolean").should == "GwtRpc::BaseExtensions::Boolean"
      @subclass.java_class_to_ruby("[Ljava.lang.String;").should == "GwtRpc::BaseExtensions::MultipartString"
      @subclass.java_class_to_ruby("com.extjs.gxt.ui.client.data.RpcMap").should == "GwtRpc::Gxt::Hash"
      @subclass.java_class_to_ruby("com.extjs.gxt.ui.client.Style$SortDir").should == "GwtRpc::Gxt::SortDir"
      @subclass.java_class_to_ruby("com.extjs.gxt.ui.client.data.SortInfo").should == "GwtRpc::Gxt::SortInfo"
      @subclass.java_class_to_ruby("com.extjs.gxt.ui.client.data.BasePagingLoadResult").should == "GwtRpc::Gxt::PaginatedResultset"
    end
  end
  
  describe ".map_classes" do
    it "should store the class mapping" do
      @subclass.map_classes "java.lang.Foo" => "Foo", "java.lang.Bar" => "Bar"
      @subclass.java_class_to_ruby("java.lang.Foo").should == "Foo"
      @subclass.java_class_to_ruby("java.lang.Bar").should == "Bar"
    end
  end
  
  describe ".ruby_class_to_java" do
    it "should return the reverse mapping" do
      @subclass.map_classes "java.lang.Foo" => "Foo", "java.lang.Bar" => "Bar"
      @subclass.ruby_class_to_java("Foo").should == "java.lang.Foo"
    end
  end
  
  describe ".add_procedure" do
    it "should add a procedure object to the set" do
      @subclass.procedures.should == {}
      @subclass.add_procedure :hello_world, :path => '/hello/world', :method => "foo", :namespace => "bar", :identifier => "abc"
      @subclass.procedures[:hello_world].should be_a(GwtRpc::Procedure)
    end
    
    it "should define a method of the same name that calls that procedure" do
      instance = @subclass.new
      instance.should_not respond_to(:test)
      @subclass.add_procedure :test, :path => '/test', :method => "foo", :namespace => "bar", :identifier => "abc"
      
      instance.should respond_to(:test)
      
      @subclass.procedures[:test].should_receive(:call).with do |client, *params|
        client.should == instance
        params.should == [1,2]
      end
      
      instance.test(1,2)
    end
  end
  
  describe "instance" do
    describe ".domain" do
      it "should read from the class's .domain" do
        @subclass.domain "example.com"
        @subclass.new.domain.should == 'example.com'
      end
    end
  end
end
