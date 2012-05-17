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

module BodyBuilder5
	# HTML5 element.
	class Element
		# Instantiates an HTML5 Element object.
		#
		# === Paramaters:
		# * +parent+ - (Element) [Required] Parent Element.
		# * +properties+ - (Hash) [Required] Hash containing Element properties:
		#		* :name - (Symbol) [Required] HTML5 tag name.
		#		* :attributes - (String) [Optional] HTML5 tag attributes.
		#		* :text - (String) [Optional] HTML5 tag text.
		#
		# === Returns:
		# * Element instance.
		#
		#	=== Example:
		#		html = BodyBuilder5::Element.new(nil, {name: :html})
		def initialize(parent, properties)
			raise(
				ArgumentError,
				"Expecting Element or nil for parent, received #{parent.class}."
			) unless parent.is_one_of?(NilClass, BodyBuilder5::Element)
			raise(
				ArgumentError,
				"Expecting Hash, received #{properties.class}"
			) unless properties.is_a?(Hash)
			raise(
				ArgumentError,
				'properties requires :name with a valid tag Symbol as its value.',
			) unless(
					properties.has_key?(:name) &&
					properties[:name].is_a?(Symbol) &&
					VALID_ELEMENTS.has_key?(properties[:name])
				)

			@parent, @name, @children = parent, properties[:name], []
			@attributes = properties[:attributes] if properties.has_key?(:attributes)
			@text = properties[:text] if properties.has_key?(:text)
		end

		public

		# Append child Element.
		#
		# === Parameters:
		# * +element+ - (Element) [Required] HTML5 Element.
		#
		# === Returns:
		# * Array of Children.
		#
		#	=== Example:
		#		p = BodyBuilder5::Element.new(div, {name: :p, text: 'Hello, world.'})
		#		div << p
		#		div.children # [.., P Instance, ..]
		def <<(element)
			raise(
				ArgumentError,
				"Expecting Element, but received #{element.class}"
			) unless element.kind_of?(Element)
			@children << element
		end

		# (Symbol) HTML5 tag name.
		attr_reader :name
		# (Element) Parent Element.
		attr_reader :parent
		# (Array) Child Elements.
		attr_reader :children
		# (String) HTML5 Element attributes.
		attr_reader :attributes
		# (String) HTML5 Element text.
		attr_reader :text
	end
end
