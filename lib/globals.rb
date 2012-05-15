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

#Global Object namespace.
#
#===Functions:
#* Document()
#* Template()
class Object
end

# METHODS

#Preferred constructor for creating a new BodyBuilder5::HeMan5.
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
#===Paramaters:
#* None
#
#===Returns:
#* HeMan5 Instance.
#
#===Example:
#
#	document = Document()
#	document.parse do
#		html
#			head
#       _title_ {text: 'Hello World'}
#     head_
#     body
#       div {attributes: 'id="content"'}
#         _p_ {text: 'What it do, my ninja?'}
#       div_
#     body_
#		html_
#	end
def Document
	BodyBuilder5::HeMan5.new
end


#	TODO: Complete documentation. (exiquio)
#Prefered constructor for creating a new BodyBuilder5::Skeletor5.
#
#===Parameters:
#* TODO:
#
#===Returns:
#* Skeletor5 Instance.
def Template
	BodyBuilder5::Skeletor5.new
end

# REVIEW: Review everything that is one to one with the HTML5 draft and ensure
#	 proper aherence to the letter of the law. (exiquio)
