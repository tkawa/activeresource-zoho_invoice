# ActiveResource Zoho Invoice

Zoho Invoice API accessor with ActiveResource

## Installation

Add this line to your application's Gemfile:

    gem 'activeresource-zoho_invoice'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeresource-zoho_invoice

## Usage

    class Invoice < ZohoInvoiceResource::Invoice
      self.auth_params = {
        apikey:    'apikeyishere',
        authtoken: 'authtokenishere',
        scope:     'invoiceapi'
      }
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
