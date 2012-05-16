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
end
