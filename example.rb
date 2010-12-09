$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'rubygems'
require 'gwt_rpc'

module RegulationsDotGov
  class Metadata
    def self.gwt_deserialize(reader)
      empty_hash = reader.read_object
      sort_info = reader.read_object
      hash = reader.read_object
      
      {hash["metadataName"] => hash["metadataValue"]}
    end
  end
  
  class DocumentDetail
    def self.gwt_deserialize(reader)
      # pop two objects off the stack that we don't care about
      reader.read_object
      reader.read_object 
      
      # grab the data we want
      details = reader.read_object
      
      # collapse array of hashes into a single hash
      details["documentMetadata"] = details["documentMetadata"].inject({}){|base, kv| base.merge!(kv)}
      
      details
    end
  end
  
  class Client < GwtRpc::Client
    domain 'www.regulations.gov'
    js_url 'http://www.regulations.gov/search/Regs/'
  
    add_procedure :document_details,
                  :path       => '/search/Regs/documentDetail',
                  :identifier => '55D5B79E395B8DDEAC09E3F41C864CA2',
                  :namespace  => 'gov.egov.erule.gwt.module.regs.client.service.DocumentDetailService',
                  :method     => 'getDocumentDetails'
  
    map_classes 'gov.egov.erule.gwt.module.regs.client.model.DocumentDetailModel' => 'RegulationsDotGov::DocumentDetail',
                'gov.egov.erule.gwt.module.regs.client.model.DocumentMetadataModel' => 'RegulationsDotGov::Metadata'
  end
end
client = RegulationsDotGov::Client.new
document_ids = ['090000648074e3cd','0900006480776e33']

document_ids.each do |document_id|
  puts client.document_details(document_id).inspect
end