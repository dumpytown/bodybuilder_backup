#!/usr/bin/env ruby

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

context 'Skeletor5' do
	setup {BodyBuilder5::Skeletor5}

	# initialization
	asserts('is a Skeletor5') {topic.new.is_a? BodyBuilder5::Skeletor5}
end
