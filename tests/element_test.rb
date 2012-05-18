#!/usr/bin/env ruby

# -*- encoding : utf-8 -*-

# element_test.rb
#
#	riot tests for BodyBuilder5::Element
#
# (C) Copyright 2012 Exiquio Cooper-Anderson, Stephen Meyers
#
# GPLv3 (www.gnu.org/licenses/gpl.html)
#
# Author(s):
#		Exiquio Cooper-Anderson (exiquio@gmail.com)
#		Stephen Meyers (?@?.com)
#
# Requirments:
#		Ruby 1.9.*

require 'riot'

require_relative '../lib/bodybuilder5.rb'

require_relative 'test_globals'

context 'Element class' do
	setup { BodyBuilder5::Element }

	# Test initialization with incorrect arguments.
	asserts_topic.raises(ArgumentError) { topic.new }

	asserts_topic.raises(ArgumentError) { topic.new(nil) }

	asserts_topic.raises(ArgumentError) { topic.new(nil, nil) }

	asserts_topic.raises(ArgumentError) { topic.new('', {name: :html}) }

	asserts_topic.raises(ArgumentError) { topic.new(nil, {}) }

	asserts_topic.raises(ArgumentError) { topic.new(nil, {name: :fish}) }

	# Test initialization with correct arguments
	denies_topic.raises(ArgumentError) { topic.new(nil, {name: :html}) }

	denies_topic.raises(ArgumentError) do
		topic.new(
			topic.new(nil, {name: :html}),
			{name: :head}
		)
	end

	asserts('initialize returns Element') do
		topic.new(nil, {name: :html}).is_a?(BodyBuilder5::Element)
	end
end


context 'Element object' do
	setup do
		BodyBuilder5::Element.new(
			BodyBuilder5::Element.new(
				nil,
				{name: :div, attributes: DIV_ATTRIBUTES}
			),
			{name: :p, text: P_TEXT}
		)
	end

	# Test attributes
	asserts('attribute name exists and it is a Symbol in VALID_ELEMENTS') do
		(
			topic.respond_to?(:name) &&
			topic.name.is_a?(Symbol) &&
			HTML5_ELEMENTS.include?(topic.name)
		)
	end

	asserts('attribute parent exists and it is a BodyBuilder5::Element') do
		topic.respond_to?(:parent) && topic.parent.is_a?(BodyBuilder5::Element)
	end

	asserts('attribute children exists and it is an Array') do
		topic.respond_to?(:children) && topic.children.is_a?(Array)
	end

	asserts('parent attributes exists, is a String and == DIV_ATTRIBUTES') do
		(
			topic.parent.respond_to?(:attributes) &&
			topic.parent.attributes.is_a?(String) &&
			topic.parent.attributes == DIV_ATTRIBUTES
		)
	end

	asserts('parent attribute is mutable') do
		parent = topic.parent
		topic.parent = 'fish' # FIXME: Rewrite to fail.
		topic.parent = parent
		parent == topic.parent
	end

	asserts('attribute text exists, is a String and == P_TEXT') do
		(
			topic.respond_to?(:text) &&
			topic.text.is_a?(String) &&
			topic.text == P_TEXT
		)
	end

	# Test methods
	asserts('reponds to :<<') { topic.respond_to?(:<<) }

	context ':<<' do
		asserts_topic.raises(ArgumentError) { topic << '' }

		asserts_topic.raises(ArgumentError) { topic << 'html' }

		asserts_topic.raises(ArgumentError) { topic << :html }

		asserts_topic.raises(ArgumentError) { topic << [1, 2, 3 ]}

		asserts_topic.raises(ArgumentError) { topic << BodyBuilder5::Element }

		denies_topic.raises(ArgumentError) { topic << topic}

		denies_topic.raises(ArgumentError) { topic << :close}

		asserts('appends to @children') do
			child_count = topic.children.length
			element = BodyBuilder5::Element.new(nil, {name: :div})
			topic << element
			topic.children.length == child_count + 1 && topic.children[-1] == element
		end
	end

	context ':render' do
		asserts('returns a String == RENDER_SNIPPET') do
			markup = topic.render
			markup.is_a?(String) && markup == RENDER_SNIPPET
		end
	end

	context ':to_s' do
		asserts('returns a String == ELEMENT_TO_S') do
			topic.to_s.is_a?(String) && topic.to_s == ELEMENT_TO_S
		end
	end
end
