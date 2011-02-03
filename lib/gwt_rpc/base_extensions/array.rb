module GwtRpc::BaseExtensions::Array
  def gwt_deserialize(reader)
    size = reader.read_int

    obj = new
    size.times do |i|
      # puts "starting array item #{i+1} of #{size}"
      obj << reader.read_object
      # puts "finished array item #{i+1} of #{size}"
    end
    # puts "!!! done with array of size #{size}"
    obj
  end
end

Array.send(:extend, GwtRpc::BaseExtensions::Array)