#!/usr/bin/env ruby

# -*- encoding : utf-8 -*-

# globals_test.rb
#
#	Behaviour tests for BodyBuilder5's globals.
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
