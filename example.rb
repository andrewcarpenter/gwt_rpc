$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'rubygems'
require 'gwt_rpc'

class RegulationsDotGovClient < GwtRpc::Client
  domain 'www.regulations.gov'
  js_url 'http://www.regulations.gov/search/Regs/'
  
  add_procedure :document_details,
                :path       => '/search/Regs/documentDetail',
                :identifier => '55D5B79E395B8DDEAC09E3F41C864CA2',
                :namespace  => 'gov.egov.erule.gwt.module.regs.client.service.DocumentDetailService',
                :method     => 'getDocumentDetails'
  
  add_procedure :search_documents,
                :path       => '/search/Regs/searchResults',
                :identifier => 'AB0B7193CC1148EFEEB8D5771D3EBF33',
                :namespace  => 'gov.egov.erule.gwt.module.regs.client.service.SearchResultsService',
                :method     => 'getSearchResultsByRelevance'
end

client = RegulationsDotGovClient.new
client.document_details('NOAA-NMFS-2008-0241-0001')
