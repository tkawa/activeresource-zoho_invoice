module ZohoInvoiceResource
  module Util
    extend self

    def underscore_keys(hash)
      hash = hash.dup
      hash.keys.each do |key|
        hash[(key.to_s.underscore rescue key) || key] = hash.delete(key)
      end
      hash
    end

    def camelize_keys(hash)
      hash = hash.dup
      hash.keys.each do |key|
        hash[(key.to_s.camelize rescue key) || key] = hash.delete(key)
      end
      hash
    end
  end
end
