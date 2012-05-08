# heman5.rb
#
# TODO
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

require_relative 'body_builder5'

module BodyBuilder5
	# HeMan performs the "heavy lifting" by providing access to all of the HTML5 tags
	# as methods following the pattern #tag_name(opt_arg1, opt_arg1) for <tag_name>,
	# tag_name_ for </tag_name> and #_tag_name_ for <tag_name></tag_name>.
	class HeMan5
		GLOBAL_ATTRIBUTES = [] # FIXME this isn't implemented in the draft yet, do test later (exiquio)

		# CATAGORIES
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

		SECTIONING_ROOT = [
			:body, :blockquote, :figure, :td
		]

		SECTIONING_CONTENT = [
			:section, :nav, :article, :aside
		]

		HEADING_CONTENT = [ # FIXME add test (exiquio)
			:h1, :h2, :h3, :h4, :h5, :h6, :header
		]

		PHRASING_CONTENT = [ # FIXME add test (exiquio)
			:script, :noscript, :br, :a, :q, :cite, :em, :strong, :small, :mark, :dfn, :abbr, :time,
			:progress, :meter, :code, :var, :samp, :kbd, :sub, :sup, :span, :i, :b, :bdo, :ruby, :ins,
			:del, :img, :iframe, :embed, :object, :video, :audio, :canvas, :area, :label, :input,
			:button, :select, :datalist, :textarea, :output, :command, :bb
		]

		EMBEDDED_CONTENT = [ # FIXME add test (exiquio)
			:img, :iframe, :embed, :object, :video, :audio, :canvas
		]

		INTERACTIVE_CONTENT = [ # FIXME add test (exiquio)
			:a, :img, :video, :audio, :label, :input, :button, :select, :textarea, :details, :bb, :menu
		]

		# TAG METADATA
		ROOT_ELEMENT = {
			html: {
				valid_attributes: ['manifest', GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [:head, :body],
				required_children: [:head, :body],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: true,
				is_singleton: true,
				omit_end_tag: false
			}
		}

		DOCUMENT_METADATA = {
			head: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [METADATA_CONTENT].flatten,
				required_children: [:title],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: true,
				is_singleton: true,
				omit_end_tag: false
			},
			title: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true,
				is_required: true,
				is_singleton: true,
				omit_end_tag: false
			},
			base: {
				valid_attributes: ['href', 'target', GLOBAL_ATTRIBUTES].flatten,
				required_attributes: ['href'],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: true,
				omit_end_tag: true
			},
			link: {
				valid_attributes: ['href', 'rel', 'media', 'hreflang', 'type', 'sizes', GLOBAL_ATTRIBUTES].flatten,
				required_attributes: ['href', 'rel', 'type'],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: true
			},
			meta: {
				valid_attributes: ['name', 'http-equiv', 'content', 'charset', GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: true
			},
			style: {
				valid_attributes: ['media', 'type', 'scoped', 'title', GLOBAL_ATTRIBUTES].flatten, # TODO docs say something about special semantics with 'title' (exiquio)
				required_attributes: ['type'],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # FIXME is this correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			}
		}

		SCRIPTING = {
			script: {
				valid_attributes: ['src', 'async', 'defer', 'type', 'charset', GLOBAL_ATTRIBUTES].flatten,
				required_attributes: ['type'],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			# TODO triple check this (exiquio)
			noscript: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [:link, :style, :meta],
				required_children: [],
				prohibited_explicitly: [:noscript],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			}
		}

		SECTIONS = {
			body: {
				valid_attributes: [
					'onbeforeunload', 'onerror', 'onhashchange', 'onload', 'onmessage',
					'onoffline', 'ononline', 'onpopstate', 'onresize', 'onstorage',
					'onunload', GLOBAL_ATTRIBUTES
				].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: true,
				is_singleton: true,
				omit_end_tag: false
			},
			section: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			nav: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			article: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			aside: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			h1: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			h2: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			h3: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			h4: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			h5: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			h6: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true, # TODO is this correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			header: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT, HEADING_CONTENT].flatten,
				required_children: [], # FIXME interesting case, requires at least one heading content descendant. how should this be handled (exiquio)
				prohibited_explicitly: [SECTIONING_CONTENT, :header, :footer].flatten,
				text_allowed: true, # FIXME is this correct (exiquio)
				text_required: false,
				is_required: false,
				is_singleton: true, # FIXME is this correct
				omit_end_tag: false
			},
			footer: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [HEADING_CONTENT, SECTIONING_CONTENT, :footer].flatten,
				text_allowed: true, # FIXME is this correct (exiquio)
				text_required: false,
				is_required: false,
				is_singleton: true, # FIXME is this correct
				omit_end_tag: false
			},
			address: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [HEADING_CONTENT, SECTIONING_CONTENT, :footer, :address].flatten,
				text_allowed: true, # FIXME is this correct (exiquio)
				text_required: false,
				is_required: false,
				is_singleton: true, # FIXME is this correct
				omit_end_tag: false
			}
		}

		GROUPING_CONTENT = {
			p: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			hr: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: true
			},
			br: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: true
			},
			pre: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			dialog: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [:dt, :dd],
				required_children: [], # TODO "Zero or more pairs of one dt element followed by one dd element" - should we even try this? (exiquio)
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			blockquote: {
				valid_attributes: ['cite', GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: true,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			ol: {
				valid_attributes: ['reversed', 'start', GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [:li],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			ul: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [:li],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			li: {
				valid_attributes: ['value', GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false, # FIXME correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			dl: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [:dt, :dd],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: false,
				text_required: false,
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			dt: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [PHRASING_CONTENT].flatten,
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false, # FIXME correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			},
			dd: {
				valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
				required_attributes: [],
				valid_children: [FLOW_CONTENT],
				required_children: [],
				prohibited_explicitly: [],
				text_allowed: true,
				text_required: false, # FIXME correct? (exiquio)
				is_required: false,
				is_singleton: false,
				omit_end_tag: false
			}
		}

		# TODO document? (exiquio)
		def initialize
			@elements = {}
			[
				ROOT_ELEMENT,
				DOCUMENT_METADATA,
				SCRIPTING,
				SECTIONS,
				GROUPING_CONTENT
			].each {|hash| @elements.merge! hash}
		end

		attr_reader :elements
	end
end
