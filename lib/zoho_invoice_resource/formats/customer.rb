module ZohoInvoiceResource
  module Formats
    class Customer < Base
      def encode(record, options={})
        options[:root] = options[:root].try(:camelize)
        # updatable attributes restricted
        data = {
          'CustomerID'     => record.customer_id,
          'Name'           => record.name,
          'PaymentsDue'    => record.payments_due,
          'BillingAddress' => record.billing_address,
          'BillingCity'    => record.billing_city,
          'BillingState'   => record.billing_state,
          'BillingZip'     => record.billing_zip,
          'BillingCountry' => record.billing_country,
          'Notes'          => record.notes,
          #'CustomFields'   => {}
        }
        data.to_xml(options).tapp
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
