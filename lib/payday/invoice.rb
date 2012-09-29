module Payday

  # Represents a renderable invoice.
  class Invoice

    # Sets the page size to use. See the
    # {http://prawn.majesticseacreature.com/docs/0.10.2/Prawn/Document/PageGeometry.html Prawn documentation} for valid
    # page_size values.
    attr_accessor :page_size

    # Sets the date format for any dates rendered on the invoice.
    # Should use strftime codes. Defaults to %B %e, %Y.
    attr_accessor :date_format

    # Currency to be used. Defaults to USD.
    attr_accessor :currency

    # Image source for the company logo. Either a raster image, or an SVG
    attr_accessor :logo

    # The width of the logo. If nil, will use the native size of the logo or
    # scale to the corresponding height.
    attr_accessor :logo_width

    # The height of the logo, If nil, will use the native size of the logo or
    # scale to the corresponding width.
    attr_accessor :logo_height

    # The unique number that this invoice can be identified by.
    attr_accessor :invoice_number

    # The date that payment for this invoice is due
    attr_accessor :due_at

    # The date that payment for this invoice was made
    attr_accessor :paid_at

    # The stamp to put onto the invoice. Can be :overdue or :paid
    attr_accessor :status_stamp

    # Name of the recipient of the payment for the invoice.
    attr_accessor :pay_to

    # Details for the recipient of the payment for the invoice.
    attr_accessor :pay_to_details

    # The name of the person or organization who should pay for the invoice.
    attr_accessor :bill_to

    # Details for the person or organization who should pay for the invoice.
    attr_accessor :bill_to_details

    # Name of the person or organization who should receive the goods
    # represented in the invoice.
    attr_accessor :ship_to

    # Details for the person or organization who should receive the goods
    # represented in the invoice.
    attr_accessor :ship_to_details

    # Description of shipping.
    attr_accessor :shipping_description

    # Price for shipping.
    attr_accessor :shipping_price

    # Description for taxes
    attr_accessor :tax_description

    # Price for taxes
    attr_accessor :tax_price

    # Subtotal for this invoice
    attr_accessor :subtotal

    # Total for this invoice
    attr_accessor :total

    # Extra information to print at the bottom of the invoice.
    attr_accessor :notes


    # Internal: Sets default values to this instance.
    def apply_defaults
      self.date_format = "%B %e, %Y"
      self.currency = "USD"
    end

    # Public: Constructs a new instance of an invoice. Accepts a block.
    #
    # Example:
    #   invoice = Payday::Invoice.new do |i|
    #     i.logo = "logo.svg"
    #     i.logo_width = "300"
    #     ...
    #   end
    def initialize(&block)
      apply_defaults
      yield(self) if block_given?
    end
  end
end
