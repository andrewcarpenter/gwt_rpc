module GwtRpc::BaseExtensions::String
  def gwt_serialize
    self
  end
end

String.send(:include, GwtRpc::BaseExtensions::String)