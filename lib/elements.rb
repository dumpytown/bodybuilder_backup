# FIXME: Encode (exiquio)
#
# FIXME: Document (exiquio)

module BodyBuilder5
	# FIXME: Document. (exiquio)
	class Element
		include Enumerable

		# FIXME: Document (exiquio)
		def initialize parent, options
			raise ArgumentException unless parent.is_? Element
			raise ArgumengException unless options.is_? Hash

			@parent, @children = parent, []
			@attributes = options[:attribute] if options.has_key? :attributes
			@text = options[:text] if options.has_key? :text
		end

		public

		# FIXME: Document (exiquio)
		def <<(element)
			raise ArgumentException unless element.ia_a? Element
			@children << element
		end

		# FIXME: Document (exiquio)
		def each
			@children.each { |element| yield element }
		end

		attr_accessor :parent, :children, :attributes, :text
end

# FIXME: Write tests (exiquio)
