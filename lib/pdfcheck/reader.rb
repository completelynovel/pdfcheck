module PDFcheck

  class Reader

    attr_accessor :details
    attr_accessor :fonts, :colors, :metadata, :security, :pages, :pages_info

    # PDFCheck.new(file_path, option)
    # options
    # - :pdfcheck_path #=> path to pdfcheck bin
    # - :tmp_dir #=> path to a tmp directory to store xml output
    # - :keep_xml #=> set to true to keep the pdfcheck output xml
    def initialize(file_path, options = {})
      raise "Unknown file type" if File.extname(file_path) != ".pdf"

      @pdfcheck_path = options[:pdfcheck_path] || "pdfcheck"
      @tmp_dir       = options[:tmp_dir] || "/tmp"
      @details       = process(file_path, options)

      @colors     = Colors.new(@details)
      @fonts      = Font.extract(@details)
      @metadata   = Metadata.new(@details)
      @pages      = Page.extract(@details)
      @pages_info = PageInfo.extract(@details)
      @security   = Security.new(@details)
    end

    def title
      title = @details.xpath("/PDFCheck/Title").first
      title.content if title
    end

    #
    # Compliance
    #
    # pdfx = reader.compliance("PDFX") #=> %<PDFcheck::PDFX>
    # pdfx.pass? #=> true
    # pdfx.report #=> {:fonts_embedded => true, ....}
    # pdfx.errors #=> []
    def compliance(name)
      case name
      when "PDF/X-1a:2001"
        PDFX1a2001.new(self)
      when "PDF/X"
        PDFX.new(self)
      when "PDF/A"
        PDFA.new(self)
      end
    end

    #
    # PDF Version
    #
    def pdf_version
      @details.xpath("/PDFCheck/Source").attr("PDFVersion").value
    end

    #
    # Fonts
    #
    def fonts_embedded?
      @fonts.all?{|f| f.embedded?}
    end

    #
    # Colors
    #
    def cmyk?
      @colors.spaces.include?("CMYK")
    end

    def rgb?
      @colors.spaces.include?("RGB")
    end

    def grayscale?
      @colors.spaces.include?("Gray")
    end

    #
    # Pages Info
    #
    def pages_count
      @pages_info.last.number
    end

    def even_pages?
      pages_count % 2 == 0
    end

    def odd_pages?
      pages_count % 2 == 1
    end

    private

    def process(file_path, options)
      filename = File.basename(file_path).sub(File.extname(file_path), "")
      temp_file_path = "#{@tmp_dir}/#{filename}.pdfcheck_#{rand(1000000)}.xml"
      command = []
      command << @pdfcheck_path
      command << file_path
      command << temp_file_path
      command << "&& cat #{temp_file_path}"
      output  = `#{command.join(" ")}`
    
      File.unlink(temp_file_path) unless options[:keep_xml]

      Nokogiri::XML.parse(output)
    end

  end
end