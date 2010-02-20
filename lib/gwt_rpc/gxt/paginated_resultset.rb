class GwtRpc::Gxt::PaginatedResultset
  attr_reader :offset, :total_count, :results
  
  def initialize(offset, total_count, results)
    @offset = offset
    @total_count = total_count
    @results = results
  end
  
  def self.gwt_deserialize(reader)
    offset = reader.read_int
    total_count = reader.read_int
    results = reader.read_object
    new(offset, total_count, results)
  end
end
