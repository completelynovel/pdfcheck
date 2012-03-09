
module PDFcheck

  class Security

    def initialize(nokodoc)
      @security = nokodoc
    end

    def encrypted?
      detail("Encrypted") == "Yes"
    end

    def printing_allowed?
      detail("PrintingAllowed") == "Yes"
    end

    def copy_allowed?
      detail("CopyAllowed") == "Yes"
    end

    def change_allowed?
      detail("CopyAllowed") == "Yes"
    end

    def add_notes_allowed?
      detail("AddNotesAllowed") == "Yes"
    end

    private

    def detail(selector)
      @security.xpath("/PDFCheck/Colors").first.attr(selector)
    end
  end

end