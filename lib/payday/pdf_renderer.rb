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
  end
end
