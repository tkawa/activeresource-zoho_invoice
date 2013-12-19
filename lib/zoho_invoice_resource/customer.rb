module ZohoInvoiceResource
  class Customer < Base
    self.primary_key = 'customer_id'

    def self.format
      self._format ||= Formats::Customer.new
    end
  end
end
