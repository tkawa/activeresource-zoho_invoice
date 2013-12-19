require 'active_record/attribute_assignment'

module ZohoInvoiceResource
  class Base < ActiveResource::Base
    include UnderscoreKeys
    include ActiveRecord::AttributeAssignment

    self.site = 'https://invoice.zoho.com/api/'
    self.include_format_in_path = false
    self.collection_parser = Collection
    class_attribute :auth_params

    class << self
      def element_path(id, prefix_options = {}, query_options = {})
        query_options.merge!(auth_params)
        super(id, prefix_options, query_options)
      end

      def collection_path(prefix_options = {}, query_options = {})
        query_options.merge!(auth_params)
        super(prefix_options, query_options)
      end

      def find_all_recursively(options = {})
        collection = find(:all, options.merge(params: {'Per_Page' => 500}))
        while collection.page && (collection.page < collection.total_pages)
          next_collection = find(:all, params: {'Page' => collection.page + 1, 'Per_Page' => 500})
          collection.merge!(next_collection)
        end
        collection
      rescue ActiveResource::ResourceNotFound
        nil
      end

      def format
        self._format ||= Formats::Base.new(self.to_s.demodulize)
      end

      # For CachedResource
      def cached_resource(options={})
        if defined?(CachedResource::Model) && self.include?(CachedResource::Model)
          super.tap do
            include CachedResourcePatch
          end
        end
      end
    end

    def update
      run_callbacks :update do
        connection.post(self.class.custom_method_collection_url(:update, prefix_options), encode, self.class.headers).tap do |response|
          load_attributes_from_response(response)
        end
      end
    end

    def update_element_path(options = nil)
      self.class.element_path(to_param, options || prefix_options)
    end

    def encode(options={})
      xml = self.class.format.encode(self, {:root => self.class.element_name}.merge(options))
      URI.encode_www_form(self.class.auth_params.merge('XMLString' => xml))
    end

    def create_resource_for(resource_name)
      super.tap do |resource|
        resource.send(:include, UnderscoreKeys)
        resource.send(:include, ActiveRecord::AttributeAssignment)
      end
    end

    def self.connection(refresh = false)
      @connection = Connection.new(site, format) if refresh || @connection.nil?
      @connection.tap do |c|
        c.proxy = proxy if proxy
        c.user = user if user
        c.password = password if password
        c.auth_type = auth_type if auth_type
        c.timeout = timeout if timeout
        c.ssl_options = ssl_options if ssl_options
      end
    end
  end
end
