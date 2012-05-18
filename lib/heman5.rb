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
		# TODO: Rewrite. (exiquio)
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

			VALID_ELEMENTS.each do |tag, tag_properties|
				# HACK: This metaprogramming will be replaced with an ember script that
				# writes HeMan5 and all of its methods to disk to prevent memory leaks
				# and reduce the performance hit. It will also give us a chance to
				# benchmark and compare the performance for further analysic. (exiquio)
				define_singleton_method(tag) do |properties = {}|
					add_open_tag(
						Element.new(
							nil,
							set_new_tag_properties(tag, properties)
						)
					)
				end

				define_singleton_method("#{tag}_".to_sym) { add_close_tag(tag) }

				define_singleton_method("_#{tag}_".to_sym) do |properties = {}|
					add_open_tag(
						Element.new(
							nil,
							set_new_tag_properties(tag, properties)
						)
					)

					add_close_tag(tag)
				end
			end
		end

		private

		# FIXME: Document. (exiqiuio)
		def add_open_tag(tag)
			raise ArgumentError, 'Tag must be an Element' unless tag.is_a?(Element)

			@parent = tag unless @parent

			if @parent.children.include?(:close)
				unless @parent.parent
					raise(
						BodyBuilder5Exception,
						"The root element is already closed: #{@parent}"
					)
				end

				@parent = @parent.parent
			else
				unless tag == @parent
					tag.parent = @parent
					@parent << tag
					@parent = tag
				end

				return true
			end

			add_open_tag(tag)
		end

		# FIXME: Document
		def add_close_tag(tag)
			raise ArgumentError, 'tag must be a Symbol.' unless tag.is_a? Symbol

			raise(
				BodyBuilder5Exception,
				"No element to close"
			) unless @parent

			if @parent.children.include?(:close)
				unless @parent.parent
					raise(
						BodyBuilder5Exception,
						"The root element is already closed: #{@parent}"
					)
				end

				@parent = @parent.parent
			else
				if tag == @parent.name
					@parent << :close
					@parent = @parent.parent unless @parent.name == :html
					return true
				else
					@parent = @parent.parent
				end
			end

			add_close_tag(tag)
		end

		# FIXME: Document. (exiquio)
		def validate_properties(properties)
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
							value.is_a?(String)
						)
				end
			end
		end

		# FIXME: Document
		def set_new_tag_properties(tag, properties)
			raise(
				ArgumentError,
				'tag must be a Symbol'
			) unless tag.is_a?(Symbol)

			validate_properties(properties)

			element_properties = {name: tag}

			if properties.has_key?(:attributes)
				element_properties[:attributes] = properties[:attributes]
			end

			if properties.has_key?(:text)
				element_properties[:text] = properties[:text]
			end

			element_properties
		end

		public

		# FIXME: Document. (exiquio)
		def render
			raise(
				BodyBuilder5Exception,
				'You can not render an empty document.'
			) unless @parent.is_a?(Element)

			loop do
				if @parent.parent
					@parent = @parent.parent
				else
					break
				end
			end

			@parent.render
		end

=begin
		# FIXME: Document. (exiqiuo)
		# FIXME: Test. (exiquio)
		def to_s
		# FIXME: @parent is nil in this scope. WTF? (exiquio)
			if @parent.is_a?(Element)
				loop do
					if @parent.parent
						@parent = @parent.parent
					else
						break
					end
				end

				@parent.to_s
			else
				''
			end
		end
=end

	end
end

# FIXME: Write HTML5 validation code. (exiquio)
#	FIXME: Fix and completed documentation. (exiquio)
# TODO: Refactor code and shorton method bodies. (exiqio)
# TODO: Ensure tests match up accurately. (exiquio)
