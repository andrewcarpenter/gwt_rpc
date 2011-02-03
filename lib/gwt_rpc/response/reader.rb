class GwtRpc::Response::Reader
  DEBUG = false
  
  attr_reader :version, :string_table, :data, :objects
  def initialize(client, json_body)
    @client = client
    (@version, placeholder, @string_table, *@data) = JSON.parse(json_body).reverse
    @max_prior_string_location = 0
    @objects = []
  end
  
  def read_int
    int = @data.shift
    puts "read int #{int}" if DEBUG
    int
  end
  
  def read_string(position=read_int)
    if position > (@max_prior_string_location + 1)
      raise "trying to read #{position}, which is too far ahead; max seen thus far is #{@max_prior_string_location}!"
    end
    
    if position > @max_prior_string_location
      @max_prior_string_location += 1
    end
    
    val = @string_table[position-1]
    puts "read str #{val} (@#{position})" if DEBUG
    
    val
  end
  
  def read_object
    int = read_int
    
    if int < 0
      obj = @objects[-1 - int]
      # if int == -11
      #   puts obj.inspect
      #   @objects.each_with_index do |doc, i|
      #     puts "#{i} => #{doc.inspect}"
      #   end
      #   exit
      # end
    elsif int > 0
      java_class = read_string(int)
      java_class.sub!(/\/\d+$/,'')
      puts "reading obj #{java_class}" if DEBUG
      ruby_class = @client.class.java_class_to_ruby(java_class)
      
      if ruby_class
        placeholder_position = @objects.count
        @objects << "PLACEHOLDER of type #{java_class}"
        
        obj = ruby_class.constantize.gwt_deserialize(self)
        @objects[placeholder_position] = obj
      else
        raise "unknown java class '#{java_class}'"
      end
    elsif int == 0
      obj = nil
    end
    obj
  end
  
  def debug
    html = "<table>\n"
    html << @data.map{|i| [i, @string_table[i-1]].map{|val| "<td>#{val}</td>"}}.map{|row| "<tr>#{row}</tr>"}.join("\n")
    html << "</table><table>\n"
    @string_table.each_with_index{|str,i| html << "<tr><td>#{i+1}</td><td>#{str}</td></tr>\n"}
    html << "</table>"
    
    html
  end
end