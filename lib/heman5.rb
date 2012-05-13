# -*- encoding : utf-8 -*-

# heman5.rb
#
# FIXME: Provide description here. (exiquio)
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

module BodyBuilder5
	# REVIEW: Ensure comment conformes to rdoc or something. (exiquio)
	# FIXME: Rewrite comment to be more readable. (exiquio)

	# HeMan5 provides an interface to build HTML5 documents.
	#
	class HeMan5
		# Object contructor that provides an interface to build HTML5 documents.
		#
		# Returns a BodyBuilder5::HeMan5 object which represents a HTML5 document
		# with each of the tags/elments implemented as methods #tag, #tag_, and
		# #_tag_ representing <tag>, </tag> and <tag></tag> respectively. Some tags
		# do not have an end tag according to the HTML5 Draft and in such cases
		# only the open method (#tag) is implemented. Otherwise expect all three.
		#
		# The #tag and #_tag_ methods take a optional Hash argument containing the
		# optional keys :attributes and :text which are both Strings in value.
		#
		# ===Paramaters:
		#   None
		#
		# ===Returns:
		#   BodyBuilder::HeMan5
		#
		# ===Example:
		#
		#   document = BodyBuilder5::HeMan5.new
		#
		#   document.html
		#     document.head
		#       document._title_ {text: 'Hello World'}
		#     document.head_
		#     document.body
		#       document.div {attributes: 'id="content"'}
		#         document._p_ {text: 'What it do, my ninja?'}
		#       document.div_
		#     document.body_
		#   document.html_
		def initialize
		end
	end
end
