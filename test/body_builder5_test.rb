#!/usr/bin/env ruby

# body_builder5_test.rb
#
#	riot tests for BodyBuilder5
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

require_relative '../lib/body_builder5.rb'

HTML5_TAGS = [
	# Root Element
	:html,
	# Document Metadata
	:head, :title, :base, :link, :meta, :style,
	# Scripting
	:script, :noscript,
	# Sections
	:body, :section, :nav, :article, :aside, :h1, :h2, :h3, :h4, :h5, :h6,
	:header, :footer, :address
]
TAG_PROPERTIES = [
	{property: :tag, type: [Symbol]},
	{property: :valid_attributes, type: [Array]},
	{property: :required_attributes, type: [Array]},
	{property: :valid_children, type: [Array]},
	{property: :required_children, type: [Array]},
	{property: :prohibited_explicitly, type: [Array]},
	{property: :text_allowed, type: [TrueClass, FalseClass]},
	{property: :text_required, type: [TrueClass, FalseClass]},
	{property: :is_required, type: [TrueClass, FalseClass]},
	{property: :is_singleton, type: [TrueClass, FalseClass]}
]

context 'BodyBuilder5Exception' do
	setup {BodyBuilder5::BodyBuilder5Exception.new}

	# initialization
	asserts('is an Exception') {topic.is_a? Exception}
end

context 'Skeletor5' do
	setup {BodyBuilder5::Skeletor5}

	# initialization
	asserts('is a Skeletor5') {topic.new.is_a? BodyBuilder5::Skeletor5}
end

context 'HeMan5' do
	setup {BodyBuilder5::HeMan5}

	# initialization
	asserts('is a HeMan5') {topic.new.is_a? BodyBuilder5::HeMan5}

	# constants
	asserts('VALID_TAGS is an array with a length > 0') {topic::VALID_TAGS.is_a?(Array) &&  topic::VALID_TAGS.length > 0}
	asserts('VALID_TAGS Hashes contain all TAG_PROPERTIES as keys with values of an appropriate type') do
		value = true
		topic::VALID_TAGS.each do |tag|
			TAG_PROPERTIES.each do |property|
				value = (
					tag.has_key?(property[:property]) &&
					property[:type].include?(tag[property[:property]].class) &&
					value ||
					false
				)
				puts "#{tag}: missing #{property[:property]} OR its value is not in #{property[:type]}" unless value
				break unless value
			end
			break unless value
		end
		value
	end
	asserts('VALID_TAGS contain all HTML5 as Symbols and these values are the value of the key :tag') do
		value = true
		topic::VALID_TAGS.each do |tag|
			value = (
				HTML5_TAGS.include?(tag[:tag]) &&
				value ||
				false
			)
			puts "#{tag} is an invalid tag" unless value
			break unless value
		end
	end
end
