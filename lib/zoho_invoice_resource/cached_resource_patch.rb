module ZohoInvoiceResource
  module CachedResourcePatch
    extend ActiveSupport::Concern

    module ClassMethods
      # override
      def cache_read(key, options = nil)
        object = cached_resource.cache.read(key, options)
        # dupしないといけないのかも
        object && cached_resource.logger.info("#{CachedResource::Configuration::LOGGER_PREFIX} READ #{key}")
        object
      end

      def cache_delete(key, options = nil)
        cached_resource.cache.delete(key, options)
      end

      def cache_exist?(key, options = nil)
        cached_resource.cache.exist?(key, options)
      end
    end

    def expire_cache
      # TODO: 本当は個別に削除したい
      # self.send(:update_singles_cache, self) して collectionのを削除するとか。
      self.class.clear_cache
    end
  end
end
