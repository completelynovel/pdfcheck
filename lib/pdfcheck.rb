require 'nokogiri'

require "pdfcheck/version"
require "pdfcheck/reader"
require "pdfcheck/compliance_base"

Dir.glob( File.expand_path("../pdfcheck/facets/*.rb", __FILE__) ).each { |file| require file }

Dir.glob( File.expand_path("../pdfcheck/compliance/*.rb", __FILE__) ).each { |file| require file }

module PDFcheck
end
