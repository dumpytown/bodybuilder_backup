# -*- encoding : utf-8 -*-

# heman5.rb
#
# (C) Copyright 2012 Exiquio Cooper-Anderson, Stephen Meyers
#
# GPLv3 (www.gnu.org/licenses/gpl.html)
#
# Author(s):
#		Exiquio Cooper-Anderson (exiquio@gmail.com)
#		Stephen Meyers (?@?.com)

module BodyBuilder5

	# HeMan5 provides an interface to build HTML5 documents.
	class HeMan5
		# Object contructor that provides an interface to build HTML5 documents.
		#
		# Returns a BodyBuilder5::HeMan5 object which represents a HTML5 document
		# with each of the tags/elments implemented as methods #tag, #tag\_, and
		# #\_tag\_ representing <tag>, </tag> and <tag></tag> respectively. Some
		# tags do not have an end tag according to the HTML5 Draft and in such
		# cases only the open method (#tag) is implemented. Otherwise expect all
		# three.
		#
		# The #tag and #\_tag\_ methods take a optional Hash argument containing
		# the optional keys :attributes and :text which are both Strings in value.
		#
		# === Paramaters:
		# * None
		#
		# === Returns:
		# * HeMan5 object
		#
		# === Example:
		# # FIXME: Provide usage example. (exiquio)
		def initialize
			@parent = nil

			VALID_ELEMENTS.each do |tag_name, tag_properties|
				# HACK: This metaprogramming will be replaced with an ember script that
				# writes HeMan5 and all of its methods to disk to prevent memory leaks
				# and reduce the performance hit. It will also give us a chance to
				# benchmark and compare the performance for further analysic. (exiquio)
				define_singleton_method(tag_name) do |properties={}|
					raise(
						ArgumentException,
						'properties must be a Hash'
					) unless properties.is_a?(Hash)

					if properties.length > 0
						properties.each do |property, value|
							raise(
								ArgumentException,
								':attributes and :text are the only allowable keys and their' +
								' values must be a String respectively.'
							) unless(
									[:attributes, :text].include?(property) &&
									value.is_a(String)
								)
						end
					end

					element_properties = {name: tag_name}

					if properties.has_key?(:attributes)
						element_properties[:attributes] = properties[:attributes]
					end

					if properties.has_key?(:text)
						element_properties = properties[:text]
					end

					add_open_tag(Element.new(nil, element_properties))
				end

				define_singleton_method("#{tag_name}_".to_sym) { add_close_tag }

				define_singleton_method("_#{tag_name}_".to_sym) do
					add_open_tag(Element.new(nil, element_properties))
					add_close_tag
				end
			end
		end

		private

		# FIXME: Document. (exiqiuio)
		def add_open_tag(tag)
			raise ArgumentError, 'Tag must be an Element' unless tag.is_a?(Element)

			@parent = tag if @parent == nil

			until @parent == nil
				if @parent.children.include?(:close)
					@parent = @parent.parent
				else
					tag.parent = @parent
					@parent << tag
					return true
				end
			end
			raise(
				BodyBuilder5Exception,
				"The root element is already closed: #{@parent}"
			)
		end

		# FIXME: Document
		def add_close_tag
			raise(
				BodyBuilder5Exception,
				'Attempt to close nil parent'
			) if @parent == nil

			raise(
				BodyBuilder5Exception,
				'Attempt to close closed parent'
			) if @parent.children.include? :close

			@parent << :close

			return true
		end
	end

	public

	# FIXME: Document. (exiqiuo)
	# FIXME: Test. (exiquio)
	# TODO: Alias render. (exiquio)
	def to_s
	end
end

# FIXME: Write HTML5 validation code. (exiquio)
