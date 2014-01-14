module ZohoInvoiceResource
  module CachedResourcePatch
    extend ActiveSupport::Concern

    module ClassMethods
      # override
      def cache_read(key)
        object = cached_resource.cache.read(key)
        # dupしないといけないのかも
        object && cached_resource.logger.info("#{CachedResource::Configuration::LOGGER_PREFIX} READ #{key}")
        object
      end

      def cache_exist?(key)
        cached_resource.cache.exist?(key)
      end
    end

    def expire_cache
      # TODO: 本当は個別に削除したい
      # self.send(:update_singles_cache, self) して collectionのを削除するとか。
      self.class.clear_cache
    end
  end
end
