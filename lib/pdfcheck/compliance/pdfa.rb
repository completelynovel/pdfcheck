module PDFcheck
  class PDFA < ComplianceBase

    def do_checks
      @report[:fonts_embedded]   = check @reader.fonts_embedded?
      @report[:intent]           = check_in @reader.metadata.output_intent, ["GTS_PDFA", "GTS_PDFA1-A"]
      @report[:unencrypted]      = check !@reader.security.encrypted?
      @report[:printing_allowed] = check @reader.security.printing_allowed?
    end

  end
end