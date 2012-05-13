# -*- encoding : utf-8 -*-

# globals.rb
#
# (C) Copyright 2012 Exiquio Cooper-Anderson, Stephen Meyers
#
# GPLv3 (www.gnu.org/licenses/gpl.html)
#
# Author(s):
#		Exiquio Cooper-Anderson (exiquio@gmail.com)
#		Stephen Meyers (?@?.com)
#
# Requirements:
#		Ruby 1.9.*+
#
# Reference:
#		http://dev.w3.org/html5/html-author/

# CLASSES

# Global Object
#
# The following methods are defined in the global namespace:
#		* Document()
#		* Template()
class Object
end

# METHODS

# Preferred constructor for creating a new BodyBuilder5::HeMan5.
#
# Returns a BodyBuilder5::HeMan5 object which represents a HTML5 documentwith
# each of the tags/elments implemented as methods #tag, #tag\_, and #\_tag\_
# representing <tag>, </tag> and <tag></tag> respectively. Some tags do not
# have an end tag according to the HTML5 Draft and in such cases only the open
# method (#tag) is implemented. Otherwise expect all three.
#
# The #tag and #\_tag\_ methods take a optional Hash argument containing
# the optional keys :attributes and :text which are both Strings in value.
#
# ===Paramaters:
#		None
#
# ===Returns:
#		BodyBuilder::HeMan5
#
# ===Example:
#
#		document = Document()
#
#		document.html
#			document.head
#				document._title_ {text: 'Hello World'}
#			document.head_
#			document.body
#				document.div {attributes: 'id="content"'}
#					document._p_ {text: 'What it do, my ninja?'}
#				document.div_
#			document.body_
#		document.html_
def Document
	BodyBuilder5::HeMan5.new
end


#	TODO: Complete documentation. (exiquio)
# Prefered constructor for creating a new BodyBuilder5::Skeletor5.
#
# ===Parameters:
#		TODO
#
# ===Returns:
#		BodyBuilder5::Skeletor5
def Template
	BodyBuilder5::Skeletor5.new
end

# REVIEW: Review everything that is one to one with the HTML5 draft and ensure
#	 proper aherence to the letter of the law. (exiquio)
