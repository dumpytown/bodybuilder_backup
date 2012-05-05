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
	:html, # Root Element
	:head, :title, :base, :link, :meta, :style # Document Metadata
]

context 'BodyBuilder5Exception' do
	setup {BodyBuilder5::BodyBuilder5Exception.new}

	# initialization
	asserts('is an Exception') {topic.is_a? Exception}
end

context 'Skeletor5' do
	setup {BodyBuilder5::Skeletor5}

	asserts('is a Skeletor5') {topic.new.is_a? BodyBuilder5::Skeletor5}
end

context 'HeMan5' do
	setup {BodyBuilder5::HeMan5}

	# initialization
	asserts('is a HeMan5') {topic.new.is_a? BodyBuilder5::HeMan5}

	# constants
	asserts('VALID_TAGS is an array with a length > 0') {topic::VALID_TAGS.is_a?(Array) &&  topic::VALID_TAGS.length > 0}
	asserts('VALID_TAGS all contain valid HTML5 tags as the value of the key :tag') do
		value = true
		topic::VALID_TAGS.each do |tag|
			value = (HTML5_TAGS.include?(tag[:tag]) && value || false)
		end
		value
	end
end
