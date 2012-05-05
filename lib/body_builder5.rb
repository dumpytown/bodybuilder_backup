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
		# HTML5 constants
		GLOBAL_ATTRIBUTES = [] # FIXME this isn't implemented in the draft yet (exiquio)

		METADATA_CONTENT = [ # FIXME add test (exiquio)
			:title, :base, :link, :meta, :style, :script, :noscript, :command
		]

		FLOW_CONTENT = [ # FIXME add test (exiquio)
			:style, :script, :noscript, :section, :nav, :article, :aside, :h1, :h2, :h3, :h4, :h5, :h6,
			:header, :footer, :address, :p, :hr, :br, :pre, :dialog, :blockquote, :ol, :ul, :dl, :a,
			:q, :cite, :em, :strong, :small, :mark, :dfn, :abbr, :time, :progress, :meter, :code, :var,
			:samp, :kbd, :sub, :sup, :span, :i, :b, :bdo, :ruby, :ins, :del, :figure, :img, :iframe,
			:embed, :object, :video, :audio, :canvas, :map, :area, :table, :form, :fieldset, :label,
			:input, :button, :select, :datalist, :textarea, :output, :details, :command, :bb, :menu,
			:div
		]

		SECTIONING_CONTENT = [
			:section, :nav, :article, :aside
		]

		HEADING_CONTENT = [ # FIXME add test (exiquio)
			:h1, :h2, :h3, :h4, :h5, :h6, :header
		]

		PHRASING_CONTENT = [ # FIXME add test (exiquio)
			:script, :noscript, :br, :q, :cite, :em, :strong, :small, :mark, :dfn, :abbr, :time, :progress,
			:meter, :code, :var, :samp, :kbd, :sub, :sup, :span, :i, :b, :bdo, :ruby, :ins, :del, :img,
			:iframe, :object, :video, :audio, :canvas, :area, :label, :input, :button, :select, :datalist,
			:textarea, :output, :command, :bb
		]

		ROOT_ELEMENT = [
			{
				tag: :html,
				valid_attributes: ['manifest', GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [:head, :body],
				required_children: [:head, :body],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: true,
				is_singleton: true
			}
		]

		DOCUMENT_METADATA = [
			{
				tag: :head,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [METADATA_CONTENT].flatten!,
				required_children: [:title],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: true,
				is_singleton: true
			},
			{
				tag: :title,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true,
				is_required: true,
				is_singleton: true
			},
			{
				tag: :base,
				valid_attributes: ['href', 'target', GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: ['href'],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: true
			},
			{
				tag: :link,
				valid_attributes: ['href', 'rel', 'media', 'hreflang', 'type', 'sizes', GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: ['href', 'rel', 'type'],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false
			},
			{
				tag: :meta,
				valid_attributes: ['name', 'http-equiv', 'content', 'charset', GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false
			},
			{
				tag: :style,
				valid_attributes: ['media', 'type', 'scoped', 'title', GLOBAL_ATTRIBUTES].flatten!, # TODO docs say something about special semantics with 'title' (exiquio)
				required_attributes: ['type'],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # FIXME is this correct? (exiquio)
				is_required: false,
				is_singleton: false
			}
		]

		SCRIPTING = [
			{
				tag: :script,
				valid_attributes: ['src', 'async', 'defer', 'type', 'charset', GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: ['type'],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false
			},
			{
				# TODO triple check this (exiquio)
				tag: :noscript,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [:link, :style, :meta],
				required_children: [],
				prohibited_explicitly: [:noscript],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false
			}
		]

		SECTIONS = [
			{
				tag: :body,
				valid_attributes: [
					'onbeforeunload', 'onerror', 'onhashchange', 'onload', 'onmessage',
					'onoffline', 'ononline', 'onpopstate', 'onresize', 'onstorage',
					'onunload', GLOBAL_ATTRIBUTES
				].flatten!,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: true,
				is_singleton: true
			},
			{
				tag: :section,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false
			},
			{
				tag: :nav,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false
			},
			{
				tag: :article,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false
			},
			{
				tag: :aside,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false
			},
			{
				tag: :h1,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false
			},
			{
				tag: :h2,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false
			},
			{
				tag: :h3,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false
			},
			{
				tag: :h4,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false
			},
			{
				tag: :h5,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false
			},
			{
				tag: :h6,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false
			},
			{
				tag: :header,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [FLOW_CONTENT, HEADING_CONTENT].flatten!,
				required_children: [], # FIXME interesting case, requires at least one heading content descendant. how should this be handled (exiquio)
				prohibited_explicitly: [SECTIONING_CONTENT, :header, :footer].flatten!,
				text_allowed: true, # FIXME is this correct (exiquio)
				text_required: false,
				is_required: false,
				is_singleton: true # FIXME is this correct
			},
			{
				tag: :footer,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [HEADING_CONTENT, SECTIONING_CONTENT, :footer].flatten!,
				text_allowed: true, # FIXME is this correct (exiquio)
				text_required: false,
				is_required: false,
				is_singleton: true # FIXME is this correct
			},
			{
				tag: :address,
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten!,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten!,
				required_children: [],
				prohibited_explicitly: [HEADING_CONTENT, SECTIONING_CONTENT, :footer, :address].flatten!,
				text_allowed: true, # FIXME is this correct (exiquio)
				text_required: false,
				is_required: false,
				is_singleton: true # FIXME is this correct
			}
		]

		VALID_TAGS = [
			ROOT_ELEMENT,
			DOCUMENT_METADATA,
			SCRIPTING,
			SECTIONS
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

# TODO important, walk the HTML documention and ensure tag metadata is correct (exiquio)
# TODO add a reject this field to tags for cases like header (exiquio)
