# -*- encoding : utf-8 -*-

# bodybuilder5.rb
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
# Requirement(s_:
#		Ruby 1.9.*+
#
# Reference(s):
#		http://dev.w3.org/html5/html-author/
#		http://www.quackit.com/html_5/

#require_relative 'elements'
require_relative 'globals'
require_relative 'heman5'
require_relative 'skeletor5'

#BodyBuilder5 namespace.
module BodyBuilder5
	# CONSTANTS

	# TODO: Global attributes are not yet implement in the HTML5 draft. (exiquio)
	# To be completed.
	GLOBAL_ATTRIBUTES = []

	# HTML5 Catagories

	# Metadata content includes elements for marking up document metadata;
	# marking up or linking to resources that describe the behaviour or
	# presentation of the document; or indicate relationships with other
	# documents.
	METADATA_CONTENT = [
		:title, :base, :link, :meta, :style, :script, :noscript, :command
	]

	# Most elements that are used in the body of documents and applications are
	# categorised as flow content. Most of the elements used to mark up the main
	# content in the body of a page are considered to be flow content. In
	# general, this includes elements that are presented visually as either
	# block level or inline level.
	FLOW_CONTENT = [
		:style, :script, :noscript, :section, :nav, :article, :aside, :h1, :h2,
		:h3, :h4, :h5, :h6, :header, :footer, :address, :p, :hr, :br, :pre,
		:dialog, :blockquote, :ol, :ul, :dl, :a, :q, :cite, :em, :strong, :small,
		:mark, :dfn, :abbr, :time, :progress, :meter, :code, :var, :samp, :kbd,
		:sub, :sup, :span, :i, :b, :bdo, :ruby, :ins, :del, :figure, :img,
		:iframe, :embed, :object, :video, :audio, :canvas, :map, :area, :table,
		:form, :fieldset, :label, :input, :button, :select, :datalist, :textarea,
		:output, :details, :command, :bb, :menu, :div
	]


	# These elements can have their own outlines, but the sections and headers
	# inside these elements do not contribute to the outlines of their ancestors.
	SECTIONING_ROOT = [
		:body, :blockquote, :figure, :td
	]

	# Sectioning content is used for structuring a document into sections, each
	# of which generally has its own heading. These elements provide a scope
	# within which associated headers, footers and contact information apply.
	SECTIONING_CONTENT = [
		:section, :nav, :article, :aside
	]

	# Heading content includes the elements for marking up headers. Headings, in
	# conjunction with the sectioning elements, are used to describe thestructure
	# of the document.
	HEADING_CONTENT = [
		:h1, :h2, :h3, :h4, :h5, :h6, :header
	]

	# Phrasing content includes text and text-level markup. This is similar to
	# the concept of inline level elements in HTML 4.01. Most elements that are
	# categorised as phrasing content can only contain other phrasing content.
	PHRASING_CONTENT = [
		:script, :noscript, :br, :a, :q, :cite, :em, :strong, :small, :mark, :dfn,
		:abbr, :time, :progress, :meter, :code, :var, :samp, :kbd, :sub, :sup,
		:span, :i, :b, :bdo, :ruby, :ins, :del, :img, :iframe, :embed, :object,
		:video, :audio, :canvas, :area, :label, :input, :button, :select,
		:datalist, :textarea, :output, :command, :bb
	]

	# Embedded content includes elements that load external resources into the
	# document.
	EMBEDDED_CONTENT = [
		:img, :iframe, :embed, :object, :video, :audio, :canvas
	]

	# Interactive elements are those that allow the user to interact with or
	# activate in some way. Depending on the user?s browser and device, this
	# could be performed using any kind of input device, such as, for example, a
	# mouse, keyboard, touch screen or voice input.
	INTERACTIVE_CONTENT = [
		:a, :img, :video, :audio, :label, :input, :button, :select, :textarea,
		:details, :bb, :menu
	]

	# HTML5 elements and their metadata

	# HTML Root Element.
	ROOT_ELEMENT = {
		html: {
			attributes: ['manifest', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:head, :body],
			required_content: [:head, :body],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: true,
			is_singleton: true,
			omit_end_tag: false
		}
	}

	# HTML5 Document Metadata elements.
	DOCUMENT_METADATA = {
		head: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [METADATA_CONTENT].flatten,
			required_content: [:title],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: true,
			is_singleton: true,
			omit_end_tag: false
		},
		title: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true,
			is_required: true,
			is_singleton: true,
			omit_end_tag: false
		},
		base: {
			attributes: ['href', 'target', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: ['href'],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: true,
			omit_end_tag: true
		},
		link: {
			attributes: [
				'href', 'rel', 'media', 'hreflang', 'type', 'sizes', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: ['href', 'rel', 'type'],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		meta: {
			attributes: [
				'name', 'http-equiv', 'content', 'charset', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		style: {
			# REVIEW: The draft mentions special semantics with 'title'. (exiquio)
			attributes: [
				'media', 'type', 'scoped', 'title', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: ['type'],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	# HTML5 Scripting elements.
	SCRIPTING = {
		script: {
			attributes: [
				'src', 'async', 'defer', 'type', 'charset', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: ['type'],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		# REVIEW: Triple check this. (exiquio)
		noscript: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:link, :style, :meta],
			required_content: [],
			prohibited_explicitly: [:noscript],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	# HTML5 Sections elements
	SECTIONS = {
		body: {
			attributes: [
				'onbeforeunload', 'onerror', 'onhashchange', 'onload', 'onmessage',
				'onoffline', 'ononline', 'onpopstate', 'onresize', 'onstorage',
				'onunload', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: true,
			is_singleton: true,
			omit_end_tag: false
		},
		section: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		nav: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		article: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		aside: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		h1: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		h2: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		h3: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		h4: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		h5: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		h6: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		header: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT, HEADING_CONTENT].flatten,
			# FIXME: This requires at least on heading content descendant. (exiquio)
			required_content: [],
			prohibited_explicitly: [SECTIONING_CONTENT, :header, :footer].flatten,
			text_allowed: true, # REVIEW: (exiquio)
			text_required: false,
			is_required: false,
			is_singleton: true, # REVIEW: (exiquio)
			omit_end_tag: false
		},
		footer: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [
				HEADING_CONTENT, SECTIONING_CONTENT, :footer
			].flatten,
			text_allowed: true, # REVIEW: (exiquio)
			text_required: false,
			is_required: false,
			is_singleton: true, # REVIEW: (exiquio)
			omit_end_tag: false
		},
		address: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [
				HEADING_CONTENT, SECTIONING_CONTENT, :footer, :address
			].flatten,
			text_allowed: true, # REVIEW: (exiquio)
			text_required: false,
			is_required: false,
			is_singleton: true, # REVIEW: (exiquio)
			omit_end_tag: false
		}
	}

	# HTML5 Grouping Content elements.
	GROUPING_CONTENT = {
		p: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		hr: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		br: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		pre: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		dialog: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:dt, :dd],
			# FIXME: This require zero or more pairs of one dt element followed by
			#		one dd element. Hmm...? (exiquio)
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		blockquote: {
			attributes: ['cite', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		ol: {
			attributes: ['reversed', 'start', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:li],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		ul: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:li],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		li: {
			attributes: ['value', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		dl: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:dt, :dd],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		dt: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		dd: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	# HTML5 Text-Level Semantics elements.
	TEXT_LEVEL_SEMANTICS = {
		a: {
			attributes: [
				'href', 'target', 'ping', 'rel', 'media', 'hreflang', 'type',
				GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [], # REVIEW: (exiquio)
			# The following is transparent. See Issues #6. (exiquio)
			content_model: [],
			required_content: [],
			prohibited_explicitly: [INTERACTIVE_CONTENT].flatten,
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		q: {
			attributes: ['cite', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		cite: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		em: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		strong: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		small: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		mark: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		dfn: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [:dfn],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		abbr: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		time: {
			attributes: ['datetime', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		progress: {
			attributes: ['value', 'max', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		meter: {
			attributes: [
				'value', 'min', 'low', 'high', 'max' 'optimum', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		code: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		var: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		samp: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		kbd: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		sub: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		sup: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		span: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		i: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		b: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		bdo: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		ruby: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			# REVIEW: "..followed either by a single rt element, or an rp element, an
			# rt element, and another rp element." (exiquio)
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		rt: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		},
		rp: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:rp].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false,
		}
	}

	# HTML5 Edits elements.
	EDITS = {
		ins: {
			attributes: ['cite', 'datetime', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [], # REVIEW: Transparent. (exiquio)
			required_content: [], # REVIEW: Transparent. (exiquio)
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		del: {
			attributes: ['cite', 'datetime', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [], # REVIEW: Transparent. (exiquio)
			required_content: [], # REVIEW: Transparent. (exiquio)
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	# HTML5 Embedded Content
	EMBEDDED_CONTENT_0 = {
		figure: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:legend, FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		img: {
			attributes: [
				'alt', 'src', 'usemap', 'ismap', 'width', 'height', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		iframe: {
			attributes: [
				'src', 'name', 'sandbox', 'seamless', 'width', 'height',
				GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		embed: {
			attributes: [
				'src', 'type', 'width', 'height', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		object: {
			attributes: [
				'data', 'type', 'name', 'usemap', 'form', 'usemap', 'form', 'width',
				'height', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [:params, :transparent].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		param: {
			attributes: ['name', 'value', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		video: {
			attributes: [
				'src', 'poster', 'autobuffer', 'autoplay', 'loop', 'controls', 'width',
				'height', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			# FIXME: If the element has a src attribute: transparent.
			#		If the element does not have a src attribute: one or more
			#		source elements, then, transparent. (exiquio)
			content_model: [:source, :transparent].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		audio: {
			attributes: [
				'src', 'autobuffer', 'autoplay', 'loop', 'controls', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			# FIXME: If the element has a src attribute: transparent.
			#		If the element does not have a src attribute: one or more source
			#		elements, then, transparent.
			content_model: [:source, :transparent].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		source: {
			attributes: ['src', 'type', 'media', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		canvas: {
			attributes: ['width', 'height', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:transparent],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		map: {
			attributes: ['name', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		area: {
			attributes: [
				'alt', 'coords', 'shape', 'href', 'target', 'ping', 'rel', 'media',
				'hreflang', 'type', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		}
	}

	# HTML5 Tabular Data
	TABULAR_DATA = {
		table: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			# FIXME: In this order: optionally a caption element, followed by either
			#		zero or more colgroup elements, followed optionally by a thead
			#		element, followed optionally by a tfoot element, followed by either
			#		zero or more tbody elements or one or more tr elements, followed
			#		optionally by a	tfoot element (but there can only be one tfoot
			#		element child in total). (exiquio)
			content_model: [:caption, :colgroup, :thead, :tfoot, :tbody, :tr],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		caption: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		colgroup: {
			attributes: ['span', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:col],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		col: {
			attributes: ['span', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		tbody: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:tr],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		thead: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:tr],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		tfoot: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:tr],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		tr: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:td, :th],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		td: {
			attributes: ['colspan', 'rowspan', 'headers', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		th: {
			attributes: [
				'colspan', 'rowspan', 'headers', 'scope', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	# HTML5 Forms
	FORMS = {
		form: {
			attributes: [
				'accept-charset', 'action', 'autocomplete', 'enctype', 'method',
				'name', 'novalidate', 'target', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [:form],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		fieldset: {
			attributes: ['disabled', 'form', 'name', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:legend, FLOW_CONTENT].flatten,
			required_content: [:legend],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		label: {
			attributes: ['form', 'for', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			# FIXME: Phrasing content, but with no descendant labelable form
			#		associated elements unless it is the element's labeled control, and
			#		no descendant label elements. (exiquio)
			content_model: [PHRASING_CONTENT],
			required_content: [],
			prohibited_explicitly: [:label],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		input: {
			attributes: [
				'accept', 'action', 'alt', 'autocomplete', 'autofocus', 'checked',
				'disabled', 'enctype', 'form', 'height', 'list', 'max', 'maxlength',
				'method', 'min', 'multiple', 'name', 'novalidate', 'pattern',
				'placeholder', 'readonly', 'required', 'size', 'source', 'step',
				'target', 'type', 'value', 'width', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		button: {
			attributes: [
				'action', 'autofocus', 'disabled', 'enctype', 'form', 'method', 'name',
				'novalidate', 'target', 'type', 'value', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [INTERACTIVE_CONTENT].flatten,
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		select: {
			attributes: [
				'autofocus', 'disabled', 'form', 'multiple', 'name', 'size',
				GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [:option, :optgroup],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		datalist: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			# FIXME: Either: phrasing content. Or: Zero or more option elements.
			#		(exqiuio)
			content_model: [:option, PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		optgroup: {
			attributes: ['disabled', 'label', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [:option],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		option: {
			attributes: [
				'disabled', 'label', 'selected', 'value', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		textarea: {
			attributes: [
				'autofocus', 'cols', 'disabled', 'form', 'maxlength', 'name',
				'readonly', 'required', 'rows', 'wrap', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		output: {
			attributes: ['for', 'form', 'name', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	# HTML5 Interactive Elements.
	INTERACTIVE_ELEMENTS = {
		details: {
			attributes: ['open', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			# REVIEW: One legend element followed by flow content. (exiquio)
			content_model: [:legend, FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		command: {
			attributes: [
				'type', 'label', 'icon', 'disabled', 'checked', 'radiogroup',
				'radiogroup', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [],
			content_model: [],
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW: (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: true
		},
		bb: {
			attributes: ['type', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [INTERACTIVE_CONTENT].flatten,
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		menu: {
			attributes: ['type', 'label', GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			# REVIEW: Either: Zero or more li elements. Or: Flow content. (exiquio)
			content_model: [:li, FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: false, # REVIEW: (exiquio)
			text_required: false,
			is_required: false,
			is_singleton: false, # REVIEW: (exiquio)
			omit_end_tag: false
		}
	}

	# HTML5 Miscellaneous Elements
	MISCELLANEOUS_ELEMENTS = {
		legend: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [PHRASING_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		div: {
			attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			content_model: [FLOW_CONTENT].flatten,
			required_content: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	# All valid HTML5 elements and their respective metadata.
	VALID_ELEMENTS = [
		ROOT_ELEMENT,
		DOCUMENT_METADATA,
		SCRIPTING,
	  SECTIONS,
	  GROUPING_CONTENT,
		TEXT_LEVEL_SEMANTICS,
		EDITS,
		EMBEDDED_CONTENT_0,
		TABULAR_DATA,
		FORMS,
		INTERACTIVE_ELEMENTS,
		MISCELLANEOUS_ELEMENTS
	].inject(:merge)

	# EXCEPTIONS

	# Generic Exception class to be thrown by BodyBuilder5 classes.
	class BodyBuilder5Exception < Exception
	end
end

# REVIEW: Review everything that is one to one with the HTML5 draft and ensure
#		proper aherence to the letter of the law. (exiquio)
