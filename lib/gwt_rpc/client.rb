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
  
  delegate :domain, :js_url, :to => "self.class"
  
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
  
  def self.add_procedure(name, options)
    procedures[name] = GwtRpc::Procedure.new(options)
    
    define_method name do |*parameters|
      self.class.procedures[name].call(self, *parameters)
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
  
  map_classes "java.lang.String"    => "String",
              "java.util.ArrayList" => "Array"
end