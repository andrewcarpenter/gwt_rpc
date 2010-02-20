require 'rubygems' # TODO: remove me
require 'active_support'
require 'typhoeus'
require 'json'

module GwtRpc
  module BaseExtensions
  end
  module Gxt
  end
end

require "gwt_rpc/client"
require "gwt_rpc/procedure"
require "gwt_rpc/request"
require "gwt_rpc/response"
require "gwt_rpc/response/reader"

require "gwt_rpc/base_extensions/array"
require "gwt_rpc/base_extensions/hash"
require "gwt_rpc/base_extensions/string"

require "gwt_rpc/gxt/hash"
require "gwt_rpc/gxt/paginated_resultset"
require "gwt_rpc/gxt/sort_dir"
require "gwt_rpc/gxt/sort_info"
