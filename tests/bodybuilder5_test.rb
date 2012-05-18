#!/usr/bin/env ruby

# -*- encoding : utf-8 -*-

# bodybuilder5_test.rb
#
#	Riot tests for BodyBuilder5
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

require_relative '../lib/bodybuilder5'

require_relative 'test_globals'

context 'BodyBuilder5 constants' do
	setup { BodyBuilder5 }

	# Test constants
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

	asserts('VALID_ELEMENTS is an hash with the correct length') do
		elements = topic::VALID_ELEMENTS
		elements.is_a?(Hash) && elements.length == HTML5_ELEMENTS.length
	end

	asserts('VALID_ELEMENTS contain all HTML5_ELEMENTS as Symbols keys') do
		value = true
		elements = topic::VALID_ELEMENTS
		HTML5_ELEMENTS.each do |element|
			value = elements.has_key?(element) && value || false
			puts "#{element} missing VALID_ELEMENTS" unless value
			break unless value
		end
		value
	end

	asserts('HTML5_ELEMENTS contain all VALID_ELEMENTS as Symbols keys') do
		value = true
		elements = topic::VALID_ELEMENTS
		elements.each do |tag_name, properties|
			value = HTML5_ELEMENTS.include?(tag_name) && value || false
			puts "#{tag_name} missing in HTML5_ELEMENTS" unless value
			break unless value
		end
		value
	end

	asserts('Each element contains all TAG_PROPERTIES with appropriate values') do
		value = true
		elements = topic::VALID_ELEMENTS
		elements.each do |tag_name, properties|
			TAG_PROPERTIES.each do |property|
				property_name, property_type = property[:name], property[:type]
				value = (
					properties.has_key?(property_name) &&
					property_type.include?(properties[property_name].class) &&
					value ||
					false
				)
				puts(
					"#{tag_name}: missing #{property_name} OR its value is not in " \
					"#{property_type}"
				) unless value
				break unless value
			end
			break unless value
		end
		value
	end
end


# Test exceptions
context 'Builder5Exception object' do
	setup { BodyBuilder5::BodyBuilder5Exception.new }

	asserts('is an Exception') {topic.is_a? Exception}
	asserts('is an BodyBuilder5Exception') do
		topic.is_a? BodyBuilder5::BodyBuilder5Exception
	end
end
