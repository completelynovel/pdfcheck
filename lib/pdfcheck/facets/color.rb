
module PDFcheck

  class Color

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
      @colors.xpath("/PDFCheck/Colors").first.attr(selector)
    end

  end

end