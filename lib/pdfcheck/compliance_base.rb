module PDFcheck
  class ComplianceBase

    def initialize(reader)
      @reader = reader
      @report = {}
      check
    end

    def report
      @report
    end

    def pass?
      @report.values.all?{ |value| value }
    end

    def errors
      errors = []
      @report.each do |criteria, pass|
        errors << criteria unless pass
      end
      errors
    end

    def check
    end

  end
end