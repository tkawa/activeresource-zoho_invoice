module ZohoInvoiceResource
  module Formats
    class Customer < Base
      def encode(record, options={})
        options[:root] = options[:root].try(:camelize)
        # updatable attributes restricted
        data = {
          'CustomerID'      => record.customer_id,
          'Name'            => record.name,
          'PaymentsDue'     => record.payments_due,
          'BillingAddress'  => record.billing_address,
          'BillingCity'     => record.billing_city,
          'BillingState'    => record.billing_state,
          'BillingZip'      => record.billing_zip,
          'BillingCountry'  => record.billing_country,
          'BillingFax'      => record.billing_fax,
          'ShippingAddress' => record.shipping_address,
          'ShippingCity'    => record.shipping_city,
          'ShippingState'   => record.shipping_state,
          'ShippingZip'     => record.shipping_zip,
          'ShippingCountry' => record.shipping_country,
          'ShippingFax'     => record.shipping_fax,
          'Contacts'        => [],
          'Notes'           => record.notes,
          'CustomFields'    => {}
        }
        record.contacts.each do |contact|
          item = {
            'ContactID'  => contact.contact_id,
            'Salutation' => contact.salutation,
            'FirstName'  => contact.first_name,
            'LastName'   => contact.last_name,
            'EMail'      => contact.e_mail,
            'Phone'      => contact.phone,
            'Mobile'     => contact.mobile
          }
          data['Contacts'] << item
        end if record.contacts
        data['CustomFields']['CustomFieldValue1'] = record.custom_fields.custom_field_value1 if record.custom_fields.custom_field_label1
        data['CustomFields']['CustomFieldValue2'] = record.custom_fields.custom_field_value2 if record.custom_fields.custom_field_label2
        data['CustomFields']['CustomFieldValue3'] = record.custom_fields.custom_field_value3 if record.custom_fields.custom_field_label3
        remove_empty!(data)
        data.to_xml(options)
      end

      def decode(xml)
        super.tap do |hash|
          # avoid weird XML structure
          %w(BillingAddress ShippingAddress).each do |attr_name|
            if hash[attr_name].is_a?(Array)
              hash[attr_name] = hash[attr_name].find{|value| value.is_a?(String)}
            end
          end
        end
      end
    end
  end
end
