module GwtRpc::BaseExtensions::String
  def self.included(base)
    base.send(:extend, ClassMethods)
    base.send(:include, InstanceMethods)
  end
  
  module InstanceMethods
    def gwt_serialize
      [self]
    end
  end
  
  module ClassMethods
    def gwt_deserialize(reader)
      reader.read_string
    end
  end
end

String.send(:include, GwtRpc::BaseExtensions::String)