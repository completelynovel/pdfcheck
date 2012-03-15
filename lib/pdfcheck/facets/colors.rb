module PDFcheck

  class Colors

    def initialize(nokodoc)
      @colors = nokodoc
    end

    def spaces
      detail("Colorspaces").split(",")
    end

    def process
      detail "Process"
    end

    def max_cmyk_density
      detail("MaxCMYKDensity").to_i
    end

    def type
      detail "Type"
    end

    private

    def detail(selector)
      attribute = @colors.xpath("/PDFCheck/Colors")
      if !attribute.empty?
        attribute.attr('Content').value
      else
        ""
      end
    end

  end

end