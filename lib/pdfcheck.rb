require "pdfcheck/version"
require "pdfcheck/color"
require "pdfcheck/font"
require "pdfcheck/metadata"
require "pdfcheck/page"
require "pdfcheck/page_info"
require "pdfcheck/security"

require 'nokogiri'

module PDFcheck

  class Reader

    attr_accessor :pdfcheck_path, :details
    attr_accessor :fonts, :color, :metadata, :security, :pages, :pages_info

    # PDFCheck.new(file_path, option)
    # options
    # - :pdfcheck_path #=> path to pdfcheck bin
    #
    def initialize(file_path, options = {})
      raise "Unknown file type" if File.extname(file_path) != ".pdf"

      @pdfcheck_path = options[:pdfcheck_path] || CONFIG['pdftools']['pdfcheck']['path']
      @details = process(file_path)

      @color      = Color.new(@details)
      @fonts      = Font.extract(@details)
      @metadata   = Metadata.new(@details)
      @pages      = Page.extract(@details)
      @pages_info = PageInfo.extract(@details)
      @security   = Security.new(@details)
    end

    def title
      @details.xpath("/PDFCheck/Title").first.content
    end

    #
    # PDF Version
    #
    def pdfx?
      pdfx_intent? && fonts_embedded?
    end

    def pdfa?
      pdfa_intent? && fonts_embedded?
    end

    def pdfx_version
      metadata.pdfx_version
    end

    def pdfx_conformance
      metadata.pdfx_version
    end

    def pdfx_2001a?
      pdfx_version == "PDF/X-1:2001" && pdfx_conformance == "PDF/X-1:2001" && !rgb?
    end

    def pdfx_intent?
      @metadata.output_intent == "GTS_PDFX"
    end

    def pdfa_intent?
      @metadata.output_intent == "GTS_PDFA1-A"
    end

    def pdf_version
      @details.xpath("/PDFCheck/Source").attr("PDFVersion").value
    end

    #
    # Fonts
    #
    def fonts_embedded?
      @fonts.all?{|f| f.embedded?}
    end

    #
    # Color
    #
    def cmyk?
      @color.spaces.include?("CMYK")
    end

    def rgb?
      @color.spaces.include?("RGB")
    end

    def grayscale?
      @color.spaces.include?("Gray")
    end

    #
    # Pages Info
    #
    def pages_count
      @pages_info.last.number
    end

    private

    def process(file_path)
      temp_file_path = "tmp/pdfcheck_#{rand(1000000)}.xml"
    
      command = "#{pdfcheck_path} '#{file_path}' #{temp_file_path} && cat #{temp_file_path}"
      output  = `#{command}`
    
      File.unlink(temp_file_path)

      Nokogiri::XML.parse(output)
    end

  end
end
