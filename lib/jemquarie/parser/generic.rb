# frozen_string_literal: true

require 'active_support'

module Jemquarie
  module Parser
    module Generic
      def generic_request_response(response)
        body = response.body
        unless body[:generate_xml_extract_response] &&
               body[:generate_xml_extract_response][:result] &&
               body[:generate_xml_extract_response][:result].is_a?(String)
          return { :error => "An error has occured, please try again later" }
        end

        result = Hash.from_xml(Nokogiri::XML.fragment(body[:generate_xml_extract_response][:result]).to_s)
        if result["XMLExtract"]["RequestDetails"]["RequestStatus"] == "Failure"
          return {
            error: result["XMLExtract"]["RequestDetails"]["RequestErrorDetails"],
            code: result["XMLExtract"]["RequestDetails"]["RequestErrorNumber"]
          }
        end

        result
      end
    end
  end
end
