module ZohoInvoiceResource
  class Connection < ActiveResource::Connection
    DEBUG = false
    def http
      configure_http(new_http).tap do |h|
        if DEBUG
          if h.respond_to?(:set_debug_output)
            h.set_debug_output($stderr)
          elsif h.respond_to?(:debug_output=) # for ActiveResource::Persistent::HTTP
            h.debug_output = $stderr
          end
        end
      end
    end

    def http_format_header(http_method)
      {HTTP_FORMAT_HEADER_NAMES[http_method] => format.mime_type(http_method)}
    end
  end
end
