# body_builder5.rb
#
# An HTML5 builder for Ruby 1.9+
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
	# Generic Exception class to be thrown by BodyBuilder5 classes
	class BodyBuilder5Exception < Exception
	end

	# HeMan performs the "heavy lifting" by providing access to all of the HTML5 tags
	# as methods following the pattern #tag_name(opt_arg1, opt_arg1) for <tag_name>,
	# tag_name_ for </tag_name> and #_tag_name_ for <tag_name></tag_name>.
	class HeMan5
		GLOBAL_ATTRIBUTES = [] # FIXME this isn't implemented in the draft yet (exiquio)

		ROOT_ELEMENT = [
			{
				tag: :html,
				valid_attributes: ['manifest'].push(GLOBAL_ATTRIBUTES),
				required_attributes: [],
				valid_children: [:head, :body],
				required_children: [:head, :body],
				text_allowed: false,
				text_required: false,
				is_required: true,
				is_singleton: true
			}
		]

		DOCUMENT_METADATA = [
			{
				tag: :head,
				valid_attributes: [].push(GLOBAL_ATTRIBUTES),
				required_attributes: [],
				valid_chidren: [:title, :base, :link, :meta, :script],
				required_children: [:title],
				text_allowed: false,
				text_required: false,
				is_required: true,
				is_singleton: true
			},
			{
				tag: :title,
				valid_attributes: [].push(GLOBAL_ATTRIBUTES),
				required_attributes: [],
				valid_children: [],
				required_chidren: [],
				text_allowed: true,
				text_required: false,
				is_required: true,
				is_singleton: true
			},
			{
				tag: :base,
				valid_attributes: ['href', 'target'].push(GLOBAL_ATTRIBUTES),
				required_attributes: ['href'],
				valid_children: [],
				required_children: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: true
			},
			{
				tag: :link,
				valid_attributes: ['href', 'rel', 'media', 'hreflang', 'type', 'sizes'].push(GLOBAL_ATTRIBUTES),
				required_attributes: ['href', 'rel', 'type'],
				valid_children: [],
				required_chidren: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: true
			},
			{
				tag: :meta,
				valid_attributes: ['name', 'http-equiv', 'content', 'charset'].push(GLOBAL_ATTRIBUTES),
				required_attributes: [],
				valid_children: [],
				required_children: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false
			},
			{
				tag: :style,
				valid_attributes: ['media', 'type', 'scoped', 'title'], # TODO docs say something about special semantics with 'title' (exiquio)
				required_attributes: ['type'],
				valid_chidren: [],
				required_children: [],
				text_allowed: true,
				text_required: true,
				is_required: false,
				is_singleton: false
			}
		]

		VALID_TAGS = [
			ROOT_ELEMENT,
			DOCUMENT_METADATA
		].flatten!

		def initialize
		end
	end

	# FIXME document (exiquio)
	class Skeletor5
		# FIXME document options thoroughly (exiquio)
		# FIXME add test for options (exiqiuo)
		def initialize #options
		end
	end
end
