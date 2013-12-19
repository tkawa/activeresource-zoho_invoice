module ZohoInvoiceResource
  class Connection < ActiveResource::Connection
    DEBUG = true
    def http
      configure_http(new_http).tap do |h|
        h.set_debug_output($stderr) if DEBUG
      end
    end

    def http_format_header(http_method)
      {HTTP_FORMAT_HEADER_NAMES[http_method] => format.mime_type(http_method)}
    end
  end
end
