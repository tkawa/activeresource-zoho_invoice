module ZohoInvoiceResource
  class Invoice < Base
    self.primary_key = 'invoice_id'

    #schema do
    #  integer :invoice_id
    #
    #end

    def self.format
      self._format ||= Formats::Invoice.new
    end

    def invoice_items_attributes=(attributes_collection)
      attributes_collection.each do |attributes|
        attributes = attributes.with_indifferent_access
        if existing_item = self.invoice_items.find{|item| item.item_id == attributes[:item_id]}
          existing_item.assign_attributes(attributes)
        else
          # TODO: raise error
        end
      end
    end
  end
end
