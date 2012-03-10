require 'spec_helper'

describe PDFcheck::Reader do

  let(:pdf_file){ File.expand_path("spec/fixtures/pdf.pdf")}
  let(:pdfa_file){ File.expand_path("spec/fixtures/pdfa.pdf")}
  let(:pdfx_file){ File.expand_path("spec/fixtures/pdfx.pdf")}

  before :all do
    @pdf  = PDFcheck::Reader.new(pdf_file, :tmp_dir => "tmp")
    @pdfa = PDFcheck::Reader.new(pdfa_file, :tmp_dir => "tmp")
    @pdfx = PDFcheck::Reader.new(pdfx_file, :tmp_dir => "tmp")
  end

  context "initialization" do
    it "should accept a file path" do
      @pdfa.should respond_to(:details)
    end
  end

  context "PDF standards" do

    describe "pdfx?" do
      it "should return true to a pdfx" do
        @pdfx.pdfx?.should be_true
      end

      it "should return false to a pdfa" do
        @pdfa.pdfx?.should be_false
      end

      it "should return false to a pdf" do
        @pdf.pdfx?.should be_false
      end
    end

    describe "pdfa?" do
      it "should return true to a pdfa" do
        @pdfa.pdfa?.should be_true
      end

      it "should return false to a pdfx" do
        @pdfx.pdfa?.should be_false
      end

      it "should return false to a pdf" do
        @pdf.pdfx?.should be_false
      end
    end

    describe "pdfx_2001a?" do
      it "should return true to a pdfx" do
        @pdfx.pdfx_2001a?.should be_true
      end

      it "should return false to a pdfa" do
        @pdfa.pdfx_2001a?.should be_false
      end

      it "should return false to a pdf" do
        @pdf.pdfx_2001a?.should be_false
      end
    end

    describe "pdf_version" do
      it "should return 1.3 to pdfx" do
        @pdfx.pdf_version.should == "1.3"
      end

      it "shouldf return 1.4 to pdfa" do
        @pdfa.pdf_version.should == "1.4"
      end

      it "should return 1.4 to pdf" do
        @pdf.pdf_version.should == "1.4"
      end
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
    # describe "cmyk?" do
    #   it "should return false when cmyk is included" do
    #     @pdfa.cmyk?.should be_false
    #   end
    # end

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

end
