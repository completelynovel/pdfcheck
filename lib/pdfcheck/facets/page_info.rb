
module PDFcheck

  class PageInfo

    def self.extract(nokodoc)
      out = []
      nokodoc.xpath("/PDFCheck/PageInfo").each do |page_info|
        out << PageInfo.new(page_info)
      end
      out
    end

    def initialize(nokodoc)
      @page_info = nokodoc
    end

    def number
      detail("Num").to_i
    end

    def media_box
      detail "MediaBox"
    end

    def crop_box
      detail "CropBox"
    end

    def bleed_box
      detail "BleedBox"
    end

    def trim_box
      detail "TrimBox"
    end

    def art_box
      detail "ArtBox"
    end

    def rotation
      detail "Rotate"
    end

    private

    def detail(selector)
      @page_info.attr(selector)
    end

  end

end