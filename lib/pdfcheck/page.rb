
module PDFcheck

  class Page

    def self.extract(nokodoc)
      out = []
      nokodoc.xpath("/PDFCheck/Page").each do |page|
        out << Page.new(page)
      end
      out
    end

    def initialize(nokodoc)
      @page = nokodoc
    end

  end

end