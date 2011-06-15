module GwtRpc::BaseExtensions::Float
  def self.included(base)
    base.send(:extend, ClassMethods)
    base.send(:include, InstanceMethods)
  end
  
  module InstanceMethods
    def gwt_serialize
      [self.to_s]
    end
  end
  
  module ClassMethods
    def gwt_deserialize(reader)
      reader.read_int.to_f
    end
  end
end

Float.send(:include, GwtRpc::BaseExtensions::Float)