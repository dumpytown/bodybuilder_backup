#!/usr/bin/env ruby

# heman5_test.rb
#
#	riot tests for BodyBuilder5::HeMan5
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

require_relative '../lib/heman5.rb'

# CONSTANTS
METADATA_CONTENT = [
	:title, :base, :link, :meta, :style, :script, :noscript, :command
]

FLOW_CONTENT = [
	:style, :script, :noscript, :section, :nav, :article, :aside, :h1, :h2, :h3, :h4, :h5, :h6,
	:header, :footer, :address, :p, :hr, :br, :pre, :dialog, :blockquote, :ol, :ul, :dl, :a,
	:q, :cite, :em, :strong, :small, :mark, :dfn, :abbr, :time, :progress, :meter, :code, :var,
	:samp, :kbd, :sub, :sup, :span, :i, :b, :bdo, :ruby, :ins, :del, :figure, :img, :iframe,
	:embed, :object, :video, :audio, :canvas, :map, :area, :table, :form, :fieldset, :label,
	:input, :button, :select, :datalist, :textarea, :output, :details, :command, :bb, :menu,
	:div
]

SECTIONING_ROOT = [
	:body, :blockquote, :figure, :td
]

SECTIONING_CONTENT = [
	:section, :nav, :article, :aside
]

HEADING_CONTENT = [
	:h1, :h2, :h3, :h4, :h5, :h6, :header
]

PHRASING_CONTENT = [
	:script, :noscript, :br, :a, :q, :cite, :em, :strong, :small, :mark, :dfn, :abbr, :time,
	:progress, :meter, :code, :var, :samp, :kbd, :sub, :sup, :span, :i, :b, :bdo, :ruby, :ins,
	:del, :img, :iframe, :embed, :object, :video, :audio, :canvas, :area, :label, :input,
	:button, :select, :datalist, :textarea, :output, :command, :bb
]

EMBEDDED_CONTENT = [
	:img, :iframe, :embed, :object, :video, :audio, :canvas
]

INTERACTIVE_CONTENT = [
	:a, :img, :video, :audio, :label, :input, :button, :select, :textarea, :details, :bb, :menu
]

HTML5_ELEMENTS = [
	# Root Element
	:html,
	# Document Metadata
	:head, :title, :base, :link, :meta, :style,
	# Scripting
	:script, :noscript,
	# Sections
	:body, :section, :nav, :article, :aside, :h1, :h2, :h3, :h4, :h5, :h6,
	:header, :footer, :address,
	# Grouping Content
	:p, :hr, :br, :pre, :dialog, :blockquote, :ol, :ul, :li, :li, :dt, :dd
]

TAG_PROPERTIES = [
	{name: :valid_attributes, type: [Array]},
	{name: :required_attributes, type: [Array]},
	{name: :valid_children, type: [Array]},
	{name: :required_children, type: [Array]},
	{name: :prohibited_explicitly, type: [Array]},
	{name: :text_allowed, type: [TrueClass, FalseClass]},
	{name: :text_required, type: [TrueClass, FalseClass]},
	{name: :is_required, type: [TrueClass, FalseClass]},
	{name: :is_singleton, type: [TrueClass, FalseClass]},
	{name: :omit_end_tag, type: [TrueClass, FalseClass]}
]

context 'HeMan5' do
	setup {BodyBuilder5::HeMan5}

	# test constants
	# TODO refactor similar tests (exiquio)
	asserts('METADATA_CONTENT is valid') do
		value = true
		METADATA_CONTENT.each do |tag|
			value = (
				topic::METADATA_CONTENT.include?(tag) &&
				value ||
				false
			)
			puts "#{tag} tag missing in METADATA_CONTENT" unless value
			break unless value
		end
		value
	end

	asserts('FLOW_CONTENT is valid') do
		value = true
		FLOW_CONTENT.each do |tag|
			value = (
				topic::FLOW_CONTENT.include?(tag) &&
				value ||
				false
			)
			puts "#{tag} tag missing in FLOW_CONTENT" unless value
			break unless value
		end
		value
	end

	asserts('SECTIONING_ROOT is valid') do
		value = true
		SECTIONING_ROOT.each do |tag|
			value = (
				topic::SECTIONING_ROOT.include?(tag) &&
				value ||
				false
			)
			puts "#{tag} tag missing in SECTIONING_ROOT" unless value
			break unless value
		end
		value
	end

	asserts('SECTIONING_CONTENT is valid') do
		value = true
		SECTIONING_CONTENT.each do |tag|
			value = (
				topic::SECTIONING_CONTENT.include?(tag) &&
				value ||
				false
			)
			puts "#{tag} tag missing in SECTIONING_CONTENT" unless value
			break unless value
		end
		value
	end

	asserts('HEADING_CONTENT is valid') do
		value = true
		HEADING_CONTENT.each do |tag|
			value = (
				topic::HEADING_CONTENT.include?(tag) &&
				value ||
				false
			)
			puts "#{tag} tag missing in HEADING_CONTENT" unless value
			break unless value
		end
		value
	end

	asserts('PHRASING_CONTENT is valid') do
		value = true
		PHRASING_CONTENT.each do |tag|
			value = (
				topic::PHRASING_CONTENT.include?(tag) &&
				value ||
				false
			)
			puts "#{tag} tag missing in PHRASING_CONTENT" unless value
			break unless value
		end
		value
	end

	asserts('EMBEDDED_CONTENT is valid') do
		value = true
		EMBEDDED_CONTENT.each do |tag|
			value = (
				topic::EMBEDDED_CONTENT.include?(tag) &&
				value ||
				false
			)
			puts "#{tag} tag missing in EMBEDDED_CONTENT" unless value
			break unless value
		end
		value
	end

	asserts('INTERACTIVE_CONTENT is valid') do
		value = true
		INTERACTIVE_CONTENT.each do |tag|
			value = (
				topic::INTERACTIVE_CONTENT.include?(tag) &&
				value ||
				false
			)
			puts "#{tag} tag missing in INTERACTIVE_CONTENT" unless value
			break unless value
		end
		value
	end

	# test initialization
	asserts('is a HeMan5') {topic.new.is_a? BodyBuilder5::HeMan5}

	# test instance variables
	asserts('elements is an hash with the correct length') do 
		elements = topic.new.elements
		elements.is_a?(Hash) && elements.length == HTML5_ELEMENTS.length
	end

	asserts('@elements contain all HTML5 elements as Symbols keys') do
		value = true
		elements = topic.new.elements
		HTML5_ELEMENTS.each do |element|
			value = (elements.has_key?(element) && value || false)
			puts "#{element} missing" unless value
			break unless value
		end
		value
	end

	asserts('each element contains all TAG_PROPERTIES with values of an appropriate type') do
		value = true
		elements = topic.new.elements
		elements.each do |tag_name, properties|
			TAG_PROPERTIES.each do |property|
				property_name, property_type = property[:name], property[:type]
				value = (
					properties.has_key?(property_name) &&
					property_type.include?(properties[property_name].class) &&
					value ||
					false
				)
				puts "#{tag_name}: missing #{property_name} OR its value is not in #{property_type}" unless value
				break unless value
			end
			break unless value
		end
		value
	end
end
