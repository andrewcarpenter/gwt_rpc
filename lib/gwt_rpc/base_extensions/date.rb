module GwtRpc::BaseExtensions::Date
  def self.included(base)
    base.send(:extend, ClassMethods)
  end
  
  module ClassMethods
    def gwt_deserialize(reader)
      reader.read_int
    end
  end
end

Date.send(:include, GwtRpc::BaseExtensions::Date)