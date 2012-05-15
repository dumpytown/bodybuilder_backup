# -*- encoding : utf-8 -*-

# element.rb
#
# (C) Copyright 2012 Exiquio Cooper-Anderson, Stephen Meyers
#
# GPLv3 (www.gnu.org/licenses/gpl.html)
#
# Author(s):
#   Exiquio Cooper-Anderson (exiquio@gmail.com)
#   Stephen Meyers (?@?.com)
#
# Requirement(s_:
#   Ruby 1.9.*+
#
# Reference(s):
#   http://dev.w3.org/html5/html-author/
#   http://www.quackit.com/html_5/


module BodyBuilder5
	# HTML5 element.
	#
	#	===Instance Variables:
	#		parent [Element] - Parent Element.
	#		children [Array] - Child Elmenets.
	#		attributes [String] - HTML5 Element attributes.
	#		text [String] - HTML5 Element text.
	class Element
		# Instantiates an HTML5 Element object.
		#
		#	===Paramaters:
		#		parent [Element] - Parent Element.
		#		properties [Hash] - Hash containing Element name, attributes and text.
		#
		#	===Returns:
		#		Element instance.
		def initialize parent, properties
			raise(
				ArgumentException,
				"Expecting Element for parent, received #{parent.class}."
			) unless parent.kind_of? Element
			raise(
				ArgumengException,
				"Expecting Hash, received #{options.class}"
			) unless options.is_a? Hash

			@parent, @children = parent, []
			@attributes = options[:attribute] if options.has_key? :attributes
			@text = options[:text] if options.has_key? :text
		end

		public

		# Append child Element.
		#
		#	===Parameters:
		#		element [Element] - HTML5 Element.
		#
		# ===Returns:
		#		Array of Children.
		def <<(element)
			raise(
				ArgumentException,
				"Expecting Element, but received #{element.class}"
			) unless element.kind_of? Element
			@children << element
		end

		attr_reader :parent, :children, :attributes, :text
end

# FIXME: Write tests (exiquio)
