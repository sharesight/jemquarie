# frozen_string_literal: true

require 'openssl'
require 'base64'

module Jemquarie
  class Base
    include Parser::Generic

    def initialize(username, password)
      @username = username
      @password = password
      @client = ::Savon.client do
        endpoint    Jemquarie::BASE_URI
        wsdl        File.expand_path('extract.wsdl', __dir__)
        log_level   Jemquarie.log_level
        log Jemquarie.log_requests
        logger Jemquarie.logger if Jemquarie.logger
        ssl_version :TLSv1_2
      end
    end

    protected

    def hash_key(key)
      Base64.strict_encode64(OpenSSL::Digest::SHA1.digest(key))
    end
  end
end
