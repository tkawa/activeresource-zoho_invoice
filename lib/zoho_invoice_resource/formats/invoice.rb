module ZohoInvoiceResource
  module Formats
    class Invoice < Base
      def encode(record, options={})
        options[:root] = options[:root].try(:camelize)
        # updatable attributes restricted
        data = {
          'InvoiceID' => record.invoice_id,
          'InvoiceDate' => normalize_date(record.invoice_date),
          'DueDate' => normalize_date(record.due_date),
          'InvoiceItems' => [],
          'CustomFields' => {}
        }
        record.invoice_items.each do |invoice_item|
          item = {
            'ItemID' => invoice_item.item_id,
            'ItemDescription' => invoice_item.item_description,
            'Price' => invoice_item.price,
            'Quantity' => invoice_item.quantity
          }
          data['InvoiceItems'] << item
        end if record.invoice_items
        if record.custom_fields.custom_label1
          # maybe can not write CustomLabel via API
          #data['CustomFields']['CustomLabel1'] = record.custom_fields.custom_label1
          data['CustomFields']['CustomField1'] = record.custom_fields.custom_field1
        end
        if record.custom_fields.custom_label2
          #data['CustomFields']['CustomLabel2'] = record.custom_fields.custom_label2
          data['CustomFields']['CustomField2'] = record.custom_fields.custom_field2
        end
        if record.custom_fields.custom_label3
          #data['CustomFields']['CustomLabel3'] = record.custom_fields.custom_label3
          data['CustomFields']['CustomField3'] = record.custom_fields.custom_field3
        end
        remove_empty!(data)
        data.to_xml(options)
      end
    end
  end
end
