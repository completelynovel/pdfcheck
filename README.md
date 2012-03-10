## Interrogate PDFs

A simple ruby wrapper around pdfcheck by Frank Siegert to interrogate PDFs (not free unfortunately).


### Basic API

```ruby
reader = PDFcheck::Reader.new("path_to_pdf")

reader.title #=> "Title"
reader.page_count #=> 529
reader.pdfx? #=> true
reader.pdfa? #=> false
reader.pdfx_2001a? #=> true
reader.pdfx_version #=> "PDF/X-1:2001"
reader.fonts_embedded? #=> true
reader.cmyk? #=> true

```

The reader takes options of

- `pdfcheck_path` to provide a path to the pdfcheck binary
- `tmp_dir` to give the directory which pdfcheck will place it's xml data files (removed afterwards)

To play about you might like to use irb `bundle exec irb -r ./lib/pdfcheck.rb`

### Fonts

Fonts can be accessed via a font class

```ruby
reader.fonts #=> [#<PDFcheck::Font::0x3eb2140>, #<PDFcheck::Font::0x3abaf140>]
font = reader.fonts.first
font.name #=> "Timesnewroman"
font.embedded? #=> true
font.subsetted? #=> true
```

### Metadata

The PDF metadata is largely about the pdf version and creator. It also contains information about embedded color profiles and creation dates.

```ruby
metadata = reader.metadata #=> #<PDFcheck::Metadata::023a532c>
metadata.author #=> "Oli Brooks"
metadata.creator #=> "Microsoft Word"
metadata.producer #=> "PStill Engine 1.72"
metadata.output_intent #=> "GTS_PDFX"
metadata.pdfx_version #=> "PDF/X-1a:2001"
metadata.pdfx_conformance #=> "PDF/X-1a:2001"

```

### Color

The color attributes of the PDF can be inspected

```ruby
color = reader.color #=> #<PDFcheck::Color::0x3eb2140>
color.spaces #=> ["CMYK", "Grey"]
color.process #=> "black"
color.max_cmyk_density #=> 120
```

### Page Info

Each page has associated info such as media, trim, art and bleed boxes and the page number

```ruby
page_info = reader.pages_info.first #=> #<PDFcheck::PageInfo::023a532c>
page_info.rotation #=> 0
page_info.number #=> 1
```