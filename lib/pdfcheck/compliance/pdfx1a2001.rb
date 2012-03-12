module PDFcheck
  class PDFX1a2001 < ComplianceBase

    def check
      @report[:fonts_embedded]   = @reader.fonts_embedded?
      @report[:no_rgb]           = !@reader.rgb?
      @report[:pdf_version]      = @reader.pdf_version == "1.3"
      @report[:max_cmyk]         = @reader.colors.max_cmyk_density < 240
      @report[:intent]           = @reader.metadata.output_intent == "GTS_PDFX"
      @report[:pdfx_version]     = @reader.metadata.pdfx_version == "PDF/X-1:2001"
      @report[:conformance]      = @reader.metadata.pdfx_conformance == "PDF/X-1a:2001"
      @report[:unencrypted]      = !@reader.security.encrypted?
      @report[:printing_allowed] = @reader.security.printing_allowed?
    end

  end
end