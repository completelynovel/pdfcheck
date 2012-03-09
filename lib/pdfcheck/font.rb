
module PDFcheck

  class Font

    def self.extract(nokodoc)
      out = []
      nokodoc.xpath("/PDFCheck/Font").each do |font|
        out << Font.new(font)
      end
      out
    end

    def initialize(nokodoc)
      @fonts = nokodoc
    end

    def embedded?
      detail("Embedded") == "Yes"
    end

    def subsetted?
      detail("Subsetted") == "Yes"
    end

    def name
      @fonts.content
    end

    private

    def detail(selector)
      @fonts.attr(selector)
    end
  end

end