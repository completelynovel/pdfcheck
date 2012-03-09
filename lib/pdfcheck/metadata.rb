
module PDFcheck

  class Metadata

    def initialize(nokodoc)
      @metadata = nokodoc
    end

    def author
      detail "Author"
    end

    def creator
      detail "Creator"
    end

    def producer
      detail "Producer"
    end

    def pdfx_version
      detail "PDFXVersion"
    end

    def pdfx_conformance
      detail "PDFXConformance"
    end

    def pdfx_embedded_color_profile
      detail "PDFXEmbeddedColorProfile"
    end

    def output_intent
      detail "PDFXOutputIntent"
    end

    def output_condition
      detail "PDFXOutputCondition"
    end

    def output_condition_identifier
      detail "PDFXOutputConditionIdentifier"
    end

    def embedded_color_profile
      detail "PDFXEmbeddedColorProfile"
    end

    def creation_date
      detail "CreationDate"
    end

    private

    def detail(selector)
      @metadata.xpath("/PDFCheck/Meta[@Name='#{selector}']").attr('Content').value
    end

  end

end