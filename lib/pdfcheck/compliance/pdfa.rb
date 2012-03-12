module PDFcheck
  class PDFA < ComplianceBase

    def check
      @report[:fonts_embedded]   = @reader.fonts_embedded?
      @report[:intent]           = @reader.metadata.output_intent == "GTS_PDFA1-A"
      @report[:unencrypted]      = !@reader.security.encrypted?
      @report[:printing_allowed] = @reader.security.printing_allowed?
    end

  end
end