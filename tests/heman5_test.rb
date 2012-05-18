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
		context ":#{tag} methods" do
			asserts("responds to \:#{tag}") { topic.respond_to?(tag) }

			asserts("responds to \:#{tag}_") { topic.respond_to?("#{tag}_".to_sym) }

			asserts("responds to \:_#{tag}_") do
				topic.respond_to?("_#{tag}_".to_sym)
			end
		end
	end

	context ':render' do
		asserts('responds to :render') { topic.respond_to?(:render) }

		asserts_topic.raises(BodyBuilder5::BodyBuilder5Exception) { topic.render }

		asserts('returns string == HTML5_DOCUMENT') do
			topic.html
				topic.head
					topic._title_ text: 'Test Document'
				topic.head_
				topic.body
					topic.div attributes: 'id="content"'
						topic._p_ text: 'This is a test'
					topic.div_
				topic.body_
			topic.html_

			markup = topic.render

			markup.is_a?(String) && markup == HTML5_DOCUMENT
		end
	end

	context ':to_s' do
		asserts('responds to :to_s') { topic.respond_to?(:to_s) }

		asserts('returns a String with length > 0') do
			topic.to_s.is_a?(String) && topic.to_s.length > 0
		end
	end
end
