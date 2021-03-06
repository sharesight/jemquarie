# frozen_string_literal: true

require 'savon'
require 'active_support/core_ext/hash'
require 'jemquarie/parser/generic'
require 'jemquarie/parser/cash_transactions'
require 'jemquarie/parser/expiry'
require 'jemquarie/parser/account_details'
require 'jemquarie/parser/balance'
require 'jemquarie/parser/service'
require 'jemquarie/base'
require 'jemquarie/importer'
require 'jemquarie/expiry'
require 'jemquarie/account_details'
require 'jemquarie/balance'
require 'jemquarie/service'

module Jemquarie
  class Jemquarie
    BASE_URI        = "https://www.macquarie.com.au/ESI/ESIWebService/Extract"
    @api_key        = nil
    @app_key        = nil
    @log_level      = nil
    @logger = nil
    @log_requests = false

    class << self
      def api_credentials(api_key, application = 'Jemquarie Gem', log_level = :warn, logger = nil, log_requests = false)
        @log_level = log_level
        Jemquarie.api_key(api_key)
        Jemquarie.app_key(application)
        @logger = logger
        @log_requests = log_requests
      end

      def api_key(api_key = nil)
        @api_key = api_key unless api_key.nil?
        @api_key
      end

      def app_key(app_key = nil)
        @app_key = app_key unless app_key.nil?
        @app_key
      end

      attr_reader :logger, :log_requests, :log_level
    end
  end
end
