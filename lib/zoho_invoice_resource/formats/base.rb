require 'ostruct'

module ZohoInvoiceResource
  module Formats
    class Base
      include ActiveResource::Formats::XmlFormat

      attr_reader :element_name
      def initialize(element_name = nil)
        @element_name = element_name || self.class.to_s.demodulize
      end

      def mime_type(http_method = :get)
        if http_method == :post
          'application/x-www-form-urlencoded'
        else
          'application/xml'
        end
      end

      def decode(xml)
        hash = ActiveResource::Formats.remove_root(Hash.from_xml(xml))
        if hash['status'] == '1'
          # success
          # single record or collection
          hash[element_name] || hash
        else
          # failure
          api_response = OpenStruct.new(Util.underscore_keys(hash))
          case api_response.code.to_i
          when 1002
            raise ActiveResource::ResourceNotFound.new(api_response)
          else
            raise ActiveResource::BadRequest.new(api_response)
          end
        end
      end

      private

      def remove_empty!(hash)
        hash.each do |key, value|
          case value
          when Hash
            remove_empty!(value)
          when Array
            value.compact!
          end
          hash.delete(key) if value.nil? || value == [] || value == {}
        end
      end

      def normalize_date(date)
        if date.match %r|\d{4}/\d{2}/\d{2}|
          date.tr('/', '-')
        else
          date
        end
      end
    end
  end
end
