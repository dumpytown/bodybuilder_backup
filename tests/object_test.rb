#!/usr/bin/env ruby

# -*- encoding : utf-8 -*-

# object_test.rb
#
#	Behaviour tests for new hacks to Object.
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

require_relative '../lib/object.rb'

require_relative 'test_globals'

context 'Object instance' do
	setup { Object.new }

	# Test methods
	context ':is_one_of?' do
		asserts('responds to :is_one_of?') { topic.respond_to?(:is_one_of?) }

		# Test with incorrect arguments.
		asserts_topic.raises(ArgumentError) { topic.is_one_of? }

		asserts_topic.raises(ArgumentError) { topic.is_one_of?(nil) }

		asserts_topic.raises(ArgumentError) { topic.is_one_of?('String') }

		# Test with correct arguments.
		denies_topic.raises(ArgumentError) { topic.is_one_of?(NilClass) }

		denies_topic.raises(ArgumentError) { topic.is_one_of?(String, Array) }

		asserts('returns boolean with false arguments') do
			[TrueClass, FalseClass].include?(topic.is_one_of?(String, Array).class)
		end

		asserts('returns boolean with true arguments') do
			[TrueClass, FalseClass].include?(topic.is_one_of?(Object).class)
		end

		asserts('returns false with false arguments') do
			topic.is_one_of?(NilClass, TrueClass, FalseClass) == false
		end

		asserts('returns true with true arguments') do
			topic.is_one_of?(String, Array, Object)
		end
	end

	context ':is_boolean?' do
		asserts('responds to :is_boolean?') { topic.respond_to?(:is_boolean?) }

		denies('returns true on non boolean objects') do
			topic.is_boolean?
		end

		asserts('rerturns true on boolean objects') do
			true.is_boolean? && false.is_boolean?
		end
	end
end


# HACK: The code below will be removed. (exiquio)
# Test functions
context 'Document function' do
	setup { method(:Document).call }

	asserts('returns a BodyBuilder5::HeMan5') { topic.is_a? BodyBuilder5::HeMan5 }
end

context 'Template function' do
	setup { method(:Template).call }

	asserts('returns a BodyBuilder5::Skeletor5') do
		topic.is_a? BodyBuilder5::Skeletor5
	end
end
