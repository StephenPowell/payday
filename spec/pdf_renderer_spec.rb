require 'spec_helper'

module Payday
  describe PdfRenderer do
    describe "#render_to_file" do
      it "should render ok" do
        i = Invoice.new

        PdfRenderer.new(i).render_to_file("tmp/test.pdf")
      end
    end

    describe "#build_pdf" do
      before do
        @invoice = Invoice.new
      end

      describe "stamp rendering" do
        it "should add a stamp to the pdf if one is given" do
          @invoice.stamp = "Overdue"

          renderer = Payday::PdfRenderer.new(@invoice)
          renderer.should_receive(:stamp)

          renderer.build_pdf
        end

        it "shouldn't add a stamp to the pdf if one isn't given" do
          renderer = Payday::PdfRenderer.new(@invoice)
          renderer.should_not_receive(:stamp)

          renderer.build_pdf
        end
      end
    end
  end
end

