class GwtRpc::Response::Reader
  attr_reader :version, :string_table, :data
  def initialize(client, json_body)
    @client = client
    (@version, placeholder, @string_table, *@data) = JSON.parse(json_body).reverse
    @max_prior_string_location = 0
    @objects = []
  end
  
  def read_int
    @data.shift
  end
  
  def read_string(position=read_int)
    if position > (@max_prior_string_location + 1)
      raise "trying to read #{position}, which is too far ahead; max seen thus far is #{@max_prior_string_location}!"
    end
    
    if position > @max_prior_string_location
      @max_prior_string_location += 1
    end
    
    @string_table[position-1]
  end
  
  def read_object
    int = read_int
    
    if int < 0
      obj = @objects[0-int]
      # log "reading from history#{int}: '#{obj}' #{@objects.inspect}"
    elsif int > 0
      java_class = read_string(int)
      java_class.sub!(/\/\d+$/,'')
      
      ruby_class = @client.class.java_class_to_ruby(java_class)
      
      if ruby_class
        obj = ruby_class.constantize.gwt_deserialize(self)
      else
        raise "unknown java class '#{java_class}'"
      end
      
      @objects << obj
    elsif int == 0
      obj = nil
    end
    obj
  end
end