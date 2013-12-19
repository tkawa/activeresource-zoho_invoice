require 'zoho_invoice_resource/version'
require 'active_support'
require 'active_resource'

module ZohoInvoiceResource
  extend ActiveSupport::Autoload

  autoload :Base
  autoload :Invoice
  autoload :Customer

  autoload :Collection
  autoload :Connection
  autoload :Formats
  autoload :UnderscoreKeys
  autoload :Util

  autoload :CachedResource
end
