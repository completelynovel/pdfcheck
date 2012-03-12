module PDFcheck
  class PDFX1a2001 < ComplianceBase

    def do_checks
      @report[:fonts_embedded]   = check @reader.fonts_embedded?
      @report[:no_rgb]           = check !@reader.rgb?
      @report[:pdf_version]      = check @reader.pdf_version, "1.3"
      @report[:max_cmyk]         = check_max @reader.colors.max_cmyk_density, 240
      @report[:intent]           = check @reader.metadata.output_intent, "GTS_PDFX"
      @report[:pdfx_version]     = check @reader.metadata.pdfx_version, "PDF/X-1:2001"
      @report[:conformance]      = check @reader.metadata.pdfx_conformance, "PDF/X-1a:2001"
      @report[:unencrypted]      = check !@reader.security.encrypted?
      @report[:printing_allowed] = check @reader.security.printing_allowed?
    end

  end
end