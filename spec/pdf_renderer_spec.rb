require 'spec_helper'

module Payday
  describe PdfRenderer do
    describe "#render_to_file" do
      it "should render a test pdf ok" do
        i = Invoice.new do |i|
          i.stamp = "Overdue"
          i.logo = "assets/tiger.svg"
          i.logo_height = 100
          i.pay_to = "Alan Johnson"
          i.pay_to_details = "321 This Way\nBeverly Hills, CA 90210\nalan@test.com"
        end

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

      describe "company logo rendering" do
        it "shouldn't draw a logo if one isn't given" do
          renderer = Payday::PdfRenderer.new(@invoice)
          renderer.should_not_receive(:render_logo)

          renderer.build_pdf
        end

        it "should draw a logo if one is given" do
          @invoice.logo = "assets/default_logo.png"

          renderer = Payday::PdfRenderer.new(@invoice)
          renderer.should_receive(:render_logo)

          renderer.build_pdf
        end

        it "should render an svg logo if the file has an svg extension" do
          @invoice.logo = "assets/tiger.svg"

          renderer = Payday::PdfRenderer.new(@invoice)
          renderer.should_receive(:render_svg_logo)

          renderer.build_pdf
        end

        it "should render a raster logo if the file doesn't have an svg extension" do
          @invoice.logo = "assets/default_logo.png"

          renderer = Payday::PdfRenderer.new(@invoice)
          renderer.should_receive(:render_raster_logo)

          renderer.build_pdf
        end
      end
    end
  end
end

