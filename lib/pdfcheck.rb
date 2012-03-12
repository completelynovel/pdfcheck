require 'nokogiri'

require "pdfcheck/version"
require "pdfcheck/reader"
require "pdfcheck/compliance_base"

Dir.glob("lib/pdfcheck/facets/*.rb").each { |file| require file }
# Dir.glob("pdfcheck/facets/*.rb").each do |file|
#   puts file
#   require file
# end
# require "pdfcheck/facets/color"
# require "pdfcheck/facets/font"
# require "pdfcheck/facets/metadata"
# require "pdfcheck/facets/page"
# require "pdfcheck/facets/page_info"
# require "pdfcheck/facets/security"

Dir.glob("lib/pdfcheck/compliance/*.rb").each do |file|
  require file
end
# require "pdfcheck/compliance"

module PDFcheck
end
