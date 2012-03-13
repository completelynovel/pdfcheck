module PDFcheck
  class ComplianceBase

    def initialize(reader)
      @reader = reader
      @report = {}
      do_checks
    end

    def report
      @report
    end

    def pass?
      @report.values.all?{ |value| value == true }
    end

    def errors
      errors = []
      @report.each do |criteria, pass|
        errors << criteria unless pass
      end
      errors
    end

    def do_checks
    end

    def check(facet, expected = true)
      facet == expected ? true : "is '#{facet}' but expected '#{expected}'"
    end

    def check_match(facet, expected = '')
      facet =~ expected ? true : "is '#{facet}' but expected to match '#{expected}'"
    end

    def check_in(facet, expected = [])
      expected.include?(facet) ? true : "is '#{facet}' but expected one of '#{expected.join(", ")}'"
    end

    def check_max(facet, expected)
      facet < expected ? true : "of '#{facet}' is greater than '#{expected}'"
    end

  end
end