module Nokogiri
  module XML
    module SAX
      class PushParser

        attr_accessor :cstruct # :nodoc:

        private

        def native_write(chunk, last_chunk) # :nodoc:
          size = 0
          unless chunk.nil?
            chunk = chunk.to_s
            size = chunk.length
          end

          rcode = LibXML.xmlParseChunk(cstruct, chunk, size, last_chunk ? 1 : 0)
          if rcode != 0
            error = LibXML.xmlCtxtGetLastError(cstruct)
            raise Nokogiri::XML::SyntaxError.wrap(error)
          end

          self
        end

        def initialize_native(sax, filename) # :nodoc:
          filename = filename.to_s unless filename.nil?
          ctx_ptr = LibXML.xmlCreatePushParserCtxt(
            sax.cstruct, nil, nil, 0, filename
            )
          raise(RuntimeError, "Could not create a parser context") if ctx_ptr.null?
          self.cstruct = LibXML::XmlSaxPushParserContext.new(ctx_ptr) ;
          self
        end

      end
    end
  end
end
