require 'rubygems' # TODO: remove me
require 'active_support'
require 'typhoeus'
require 'json'

module GwtRpc
  module BaseExtensions
  end
end

require "gwt_rpc/client"
require "gwt_rpc/procedure"
require "gwt_rpc/request"
require "gwt_rpc/response"
require "gwt_rpc/response/reader"

require "gwt_rpc/base_extensions/string"