module Payday
  class PdfRenderer
    # The invoice that we're rendering
    attr_accessor :invoice

    # Internal: The Prawn::Document that we're working with.
    attr_accessor :pdf

    # Internal: Create a new instance of a pdf renderer.
    #
    # You shouldn't need to use this directly, as instances of invoice know
    # how to render.
    def initialize(invoice)
      self.invoice = invoice
      self.pdf = Prawn::Document.new(:page_size => invoice.page_size)

      build_pdf
    end

    # Internal: Renders the pdf to file.
    def render_to_file(path)
      pdf.render_file(path)
    end

    # Internal: Builds a Prawn document that we can use to write to disk or
    # render to a stream.
    def build_pdf
      pdf.font_size(8)

      stamp unless invoice.stamp.nil?
      logo
      pay_to_banner
    end

    # Internal: Resets the drawing fill color to black.
    def reset_fill_color
      pdf.fill_color "000000"
    end

    # Internal: Sets our text to bold.
    def bold(&block)
      pdf.font("Helvetica-Bold") do
        yield
      end
    end

    def cell(text, options = {})
      pdf.make_cell(text, options)
    end

    # Internal: Renders a bold cell.
    def bold_cell(text, options = {})
      options[:font] = "Helvetica-Bold"
      cell(text, options)
    end

    # Internal: Prints a red stamp on the invoice, either saying that it's
    # paid or that it's overdue.
    def stamp
      pdf.bounding_box([150, pdf.cursor - 50], :width => pdf.bounds.width - 300) do
        bold do
          pdf.fill_color("cc0000")
          pdf.text(invoice.stamp, :align=> :center, :size => 25, :rotate => 15)
        end
      end

      reset_fill_color
    end

    # Internal: Renders the logo
    def logo
      logo_offset = 0
      logo_offset = render_logo unless invoice.logo.nil?
    end

    # Internal: Renders the pay_to information.
    def pay_to_banner
      table_data = []
      unless invoice.pay_to.nil?
        table_data << [bold_cell(invoice.pay_to, :size => 12)]
      end

      unless invoice.pay_to_details.nil?
        invoice.pay_to_details.lines.each { |line| table_data << [line] }

        table = pdf.make_table(table_data, :cell_style => { :borders => [], :padding => 0 })
        pdf.bounding_box([pdf.bounds.width - table.width, pdf.bounds.top], :width => table.width, :height => table.height + 5) do
          table.draw
        end
      end
    end

    # Internal: Renders the logo for the invoice.
    #
    # Returns the offset that the logo generated.
    def render_logo
      if invoice.is_logo_svg?
        render_svg_logo
      else
        render_raster_logo
      end
    end

    # Internal: Renders the logo as an svg image.
    #
    # Returns the offset for the logo.
    def render_svg_logo
      logo_info = pdf.svg(File.read(invoice.logo), :at => pdf.bounds.top_left,
                          :width => invoice.logo_width,
                          :height => invoice.logo_height)
      logo_info[:height]
    end

    # Internal: Renders the logo as a raster image.
    #
    # Returns the offset for the logo.
    def render_raster_logo
      logo_info = pdf.image(invoice.logo, :at => pdf.bounds.top_left,
                          :width => invoice.logo_width,
                          :height => invoice.logo_height)

      # Return the offset for the logo
      logo_info.scaled_height
    end
  end
end
