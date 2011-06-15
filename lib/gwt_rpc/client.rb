class GwtRpc::Client
  def self.domain(domain = nil)
    if domain
      @domain = domain
    end
    @domain
  end
  
  def self.js_url(js_url = nil)
    if js_url
      @js_url = js_url
    end
    @js_url
  end
  
  def self.gwt_permutation(permutation = nil)
    if permutation
      @gwt_permutation = permutation
    end
    @gwt_permutation
  end
  
  delegate :domain, :js_url, :gwt_permutation, :to => "self.class"
  
  def self.map_classes(mapping)
    @class_map ||= {}
    mapping.each_pair do |java_class, ruby_class|
      @class_map[java_class.to_s] = ruby_class.to_s
    end
  end
  
  def self.ruby_class_to_java(klass)
    @class_map.invert[klass.to_s]
  end
  
  def self.java_class_to_ruby(klass)
    @class_map[klass.to_s]
  end
  
  def self.add_procedure(name, options, &block)
    procedures[name] = GwtRpc::Procedure.new(options, &block)
    
    define_method name do |*parameters|
      self.class.procedures[name].call(self, *parameters)
    end
    
    define_method "#{name}_request" do |*parameters|
      self.class.procedures[name].request(self, *parameters)
    end
  end
  
  def self.procedures
    @procedures ||= {}
  end
  
  def self.inherited(subclass)
    subclass.domain     self.domain
    subclass.js_url     self.js_url
    
    subclass.map_classes @class_map
  end
  
  map_classes "java.lang.String"                                  => "String",
              "java.util.ArrayList"                               => "Array",
              "java.util.Date"                                    => "Date",
              "java.lang.Long"                                    => "Float",
              "java.util.HashMap"                                 => "Hash",
              "java.lang.Integer"                                 => "Fixnum",
              "java.lang.Boolean"                                 => "GwtRpc::BaseExtensions::Boolean",
              "[Ljava.lang.String;"                               => "GwtRpc::BaseExtensions::MultipartString",
              "com.extjs.gxt.ui.client.data.RpcMap"               => "GwtRpc::Gxt::Hash",
              "com.extjs.gxt.ui.client.Style$SortDir"             => "GwtRpc::Gxt::SortDir",
              "com.extjs.gxt.ui.client.data.SortInfo"             => "GwtRpc::Gxt::SortInfo",
              "com.extjs.gxt.ui.client.data.BasePagingLoadResult" => "GwtRpc::Gxt::PaginatedResultset"
end