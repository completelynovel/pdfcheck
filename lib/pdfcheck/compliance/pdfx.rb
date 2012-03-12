module PDFcheck
  class PDFX < ComplianceBase

    def check
      @report[:fonts_embedded]   = @reader.fonts_embedded?
      @report[:no_rgb]           = !@reader.rgb?
      @report[:pdf_version]      = @reader.pdf_version == "1.3"
      @report[:intent]           = @reader.metadata.output_intent == "GTS_PDFX"
      @report[:unencrypted]      = !@reader.security.encrypted?
      @report[:printing_allowed] = @reader.security.printing_allowed?
    end

  end
end