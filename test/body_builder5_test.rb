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

context 'BodyBuilder5Exception' do
	setup {BodyBuilder5::BodyBuilder5Exception.new}

	asserts('is an Exception') {topic.is_a? Exception}
	asserts('is an BodyBuilderException') do
		topic.is_a? BodyBuilder5::BodyBuilder5Exception
	end
end
