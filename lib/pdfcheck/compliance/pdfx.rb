module PDFcheck
  class PDFX < ComplianceBase

    def do_checks
      @report[:fonts_embedded]   = check @reader.fonts_embedded?
      @report[:no_rgb]           = check !@reader.rgb?
      @report[:pdf_version]      = check @reader.pdf_version, "1.3"
      @report[:intent]           = check_in @reader.metadata.output_intent, ["GTS_PDFX", "GTS_PDFX-A"]
      @report[:unencrypted]      = check !@reader.security.encrypted?
      @report[:printing_allowed] = check @reader.security.printing_allowed?
    end

  end
end