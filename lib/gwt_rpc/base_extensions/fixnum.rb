module GwtRpc::BaseExtensions::Fixnum
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
      reader.read_int
    end
  end
end

Fixnum.send(:include, GwtRpc::BaseExtensions::Fixnum)