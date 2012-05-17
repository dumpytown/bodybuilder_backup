#!/usr/bin/env ruby

# -*- encoding : utf-8 -*-

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

require_relative '../lib/bodybuilder5.rb'

require_relative 'test_globals'

context 'HeMan5 object' do
	setup { BodyBuilder5::HeMan5.new }

	# Test initialization
	asserts('is a HeMan5') { topic.is_a? BodyBuilder5::HeMan5 }

	# Single out @parent
	asserts('@parent is nil') { topic.instance_variable_get(:@parent) == nil }

	# Test Methods
	HTML5_ELEMENTS.each do |tag|
		asserts("responds to \:#{tag}") { topic.respond_to?(tag) }

		asserts("responds to \:#{tag}_") { topic.respond_to?("#{tag}_".to_sym) }

		asserts("responds to \:_#{tag}_") { topic.respond_to?("_#{tag}_".to_sym) }
	end
end
