require 'spec_helper'

describe PDFcheck::Reader do

  let(:pdf_file){ File.expand_path("spec/fixtures/pdf.pdf")}
  let(:pdfa_file){ File.expand_path("spec/fixtures/pdfa.pdf")}
  let(:pdfx_file){ File.expand_path("spec/fixtures/pdfx.pdf")}

  let(:pdf_cover){ File.expand_path("spec/fixtures/cover.pdf")}
  let(:pdfx_cover){ File.expand_path("spec/fixtures/cover-pdfx.pdf")}

  before :all do
    @pdf  = PDFcheck::Reader.new(pdf_file, :tmp_dir => "tmp")
    @pdfa = PDFcheck::Reader.new(pdfa_file, :tmp_dir => "tmp")
    @pdfx = PDFcheck::Reader.new(pdfx_file, :tmp_dir => "tmp")

    @cover_pdf = PDFcheck::Reader.new(pdf_cover, :tmp_dir => "tmp")
    @cover_pdfx = PDFcheck::Reader.new(pdfx_cover, :tmp_dir => "tmp")
  end

  context "initialization" do
    it "should accept a file path" do
      @pdfa.should respond_to(:details)
    end
  end

  describe "fonts" do

    describe "fonts_embedded?" do
      it "should return true to a pdfx" do
        @pdfx.fonts_embedded?.should be_true
      end

      it "should return true to a pdfa" do
        @pdfa.fonts_embedded?.should be_true
      end

      # it "should return false to a pdf" do
      #   @pdf.fonts_embedded?.should be_false
      # end
    end
  end

  context "colors" do
    describe "cmyk?" do
      it "should return false when cmyk is included" do
        @cover_pdfx.cmyk?.should be_true
      end
    end

    describe "rgb?" do
      it "should return true when rgb is included" do
        @pdf.rgb?.should be_true
      end
    end

    describe "grayscale?" do
      it "should return false when grayscale is included" do
        @pdfx.grayscale?.should be_true
      end
    end
  end

  context "pages" do
    describe "pages_count" do
      it "should return 327 to pdfa" do
        @pdfa.pages_count.should == 327
      end

      it "should return 86 to pdfx" do
        @pdfx.pages_count.should == 86
      end
    end

    describe "even_pages?" do
      it "should return true with an even number of pages" do
        @pdfx.even_pages?.should be_true
      end

      it "should return false with an odd number of pages" do
        @pdfa.even_pages?.should be_false
      end
    end

    describe "odd_pages?" do
      it "should return true if an odd number of pages" do
        @pdfa.odd_pages?.should be_true
      end

      it "should return false if an even number of pages" do
        @pdfx.odd_pages?.should be_false
      end
    end
  end

  context "compliance" do
    describe "check_compliance(name)" do
      it "should return a PDFX2001a object when given 'PDF/X-1a:2001'" do
        @pdfx.compliance('PDF/X-1a:2001').should be_a(PDFcheck::PDFX1a2001)
        # puts @pdfx.compliance('PDF/X-1a:2001').report.inspect
        @pdfx.compliance('PDF/X-1a:2001').pass?.should be_true
        @pdfa.compliance('PDF/X-1a:2001').pass?.should be_false
      end

      it "should return a PDFX object when given 'PDF/X'" do
        @pdfx.compliance('PDF/X').should be_a(PDFcheck::PDFX)
        # puts @pdfx.compliance('PDF/X').report.inspect
        @pdfx.compliance('PDF/X').pass?.should be_true
        @pdfa.compliance('PDF/X').pass?.should be_false
      end

      it "should return a PDFA object when given 'PDF/A'" do
        @pdfa.compliance('PDF/A').should be_a(PDFcheck::PDFA)
        # puts @pdfa.compliance('PDF/A').report.inspect
        @pdfa.compliance('PDF/A').pass?.should be_true
      end
    end

  end

end
