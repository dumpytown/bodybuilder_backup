#!/usr/bin/env ruby

# -*- encoding : utf-8 -*-

# skeletor5_test.rb
#
#	riot tests for BodyBuilder5::Skeletor5
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

require_relative '../lib/skeletor5.rb'

require_relative 'test_globals'

context 'Skeletor5 object' do
	setup {BodyBuilder5::Skeletor5.new}

	# Test initialization
	asserts('is a Skeletor5') {topic.is_a? BodyBuilder5::Skeletor5}
end
