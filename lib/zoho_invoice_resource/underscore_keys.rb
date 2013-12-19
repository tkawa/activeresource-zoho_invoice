module ZohoInvoiceResource
  module UnderscoreKeys
    def load(attributes, remove_root = false, persisted = false)
      raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
      attributes = Util.underscore_keys(attributes)
      @prefix_options, attributes = split_options(attributes)

      if attributes.keys.size == 1
        remove_root = self.class.element_name == attributes.keys.first.to_s
      end

      attributes = ActiveResource::Formats.remove_root(attributes) if remove_root

      attributes.each do |key, value|
        @attributes[key.to_s] =
          if value.is_a?(Array) ||
            (value.is_a?(Hash) && value.keys.size == 1 && value = value.values.flatten)
            resource = nil
            value.map do |attrs|
              if attrs.is_a?(Hash)
                resource ||= find_or_create_resource_for_collection(key)
                resource.new(attrs, persisted)
              else
                attrs.duplicable? ? attrs.dup : attrs
              end
            end
          elsif value.is_a?(Hash)
            resource = find_or_create_resource_for(key)
            resource.new(value, persisted)
          else
            value.duplicable? ? value.dup : value
          end
      end
      self
    end
  end
end
