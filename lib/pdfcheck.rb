require 'nokogiri'

require "pdfcheck/version"
require "pdfcheck/reader"
require "pdfcheck/compliance_base"

Dir.glob("lib/pdfcheck/facets/*.rb").each { |file| require file }

Dir.glob("lib/pdfcheck/compliance/*.rb").each do |file|
  require file
end

module PDFcheck
end
