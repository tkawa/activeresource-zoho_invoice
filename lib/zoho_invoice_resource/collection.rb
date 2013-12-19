module ZohoInvoiceResource
  class Collection < ActiveResource::Collection
    attr_reader :page, :pages, :per_page, :total, :total_pages
    def initialize(hash)
      @element_hash = hash
      if hash['PageContext']
        @page = hash['PageContext']['Page'].to_i
        @pages = [@page]
        @per_page = hash['PageContext']['Per_Page'].to_i
        @total = hash['PageContext']['Total'].to_i
        @total_pages = hash['PageContext']['Total_Pages'].to_i
      end
    end

    def elements
      @elements ||= begin
        name = resource_class.name
        @element_hash[name.pluralize][name]
      end
    end

    def collect!
      elements # prepare @elements
      super
    end

    def merge!(another)
      another.each do |element|
        elements << element
      end
      @pages = [@page, another.page].flatten
      @page = another.page
      @per_page = another.per_page
      @total = another.total
      @total_pages = another.total_pages
    end
  end
end
