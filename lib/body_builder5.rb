# -*- encoding : utf-8 -*-

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

require_relative 'heman5'
require_relative 'skeletor5'

module BodyBuilder5
	# CONSTANTS
	
	# TODO: Global attributes are not yet implement in the HTML5 draft. (exiquio)
	GLOBAL_ATTRIBUTES = [] 

	# HTML5 Catagories
	METADATA_CONTENT = [
		:title, :base, :link, :meta, :style, :script, :noscript, :command
	]

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

	SECTIONING_ROOT = [
		:body, :blockquote, :figure, :td
	]

	SECTIONING_CONTENT = [
		:section, :nav, :article, :aside
	]

	HEADING_CONTENT = [
		:h1, :h2, :h3, :h4, :h5, :h6, :header
	]

	PHRASING_CONTENT = [
		:script, :noscript, :br, :a, :q, :cite, :em, :strong, :small, :mark, :dfn,
		:abbr, :time, :progress, :meter, :code, :var, :samp, :kbd, :sub, :sup,
		:span, :i, :b, :bdo, :ruby, :ins, :del, :img, :iframe, :embed, :object,
		:video, :audio, :canvas, :area, :label, :input, :button, :select,
		:datalist, :textarea, :output, :command, :bb
	]

	EMBEDDED_CONTENT = [
		:img, :iframe, :embed, :object, :video, :audio, :canvas
	]

	INTERACTIVE_CONTENT = [
		:a, :img, :video, :audio, :label, :input, :button, :select, :textarea,
		:details, :bb, :menu
	]

	# HTML5 elements and their metadata 
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
			valid_attributes: [
				'href', 'rel', 'media', 'hreflang', 'type', 'sizes', GLOBAL_ATTRIBUTES
			].flatten,
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
			valid_attributes: [
				'name', 'http-equiv', 'content', 'charset', GLOBAL_ATTRIBUTES
			].flatten,
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
			# REVIEW: The draft mentions special semantics with 'title'. (exiquio)
			valid_attributes: [
				'media', 'type', 'scoped', 'title', GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: ['type'],
			valid_children: [],
			required_children: [],
			prohibited_explicitly: [],
			text_allowed: true,
			text_required: true, # REVIEW (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	SCRIPTING = {
		script: {
			valid_attributes: [
				'src', 'async', 'defer', 'type', 'charset', GLOBAL_ATTRIBUTES
			].flatten,
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
		# REVIEW: Triple check this. (exiquio)
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
			text_required: true, # REVIEW (exiquio) 
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
			text_required: true, # REVIEW (exiquio)
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
			text_required: true, # REVIEW (exiquio)
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
			text_required: true, # REVIEW (exiquio)
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
			text_required: true, # REVIEW (exiquio)
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
			text_required: true, # REVIEW (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		},
		header: {
			valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			valid_children: [FLOW_CONTENT, HEADING_CONTENT].flatten,
			# FIXME: This requires at least on heading content descendant. (exiquio)
			required_children: [],
			prohibited_explicitly: [SECTIONING_CONTENT, :header, :footer].flatten,
			text_allowed: true, # REVIEW (exiquio)
			text_required: false,
			is_required: false,
			is_singleton: true, # REVIEW (exiquio)
			omit_end_tag: false
		},
		footer: {
			valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			valid_children: [FLOW_CONTENT].flatten,
			required_children: [],
			prohibited_explicitly: [
				HEADING_CONTENT, SECTIONING_CONTENT, :footer
			].flatten,
			text_allowed: true, # REVIEW (exiquio)
			text_required: false,
			is_required: false,
			is_singleton: true, # REVIEW (exiquio)
			omit_end_tag: false
		},
		address: {
			valid_attributes: [GLOBAL_ATTRIBUTES].flatten,
			required_attributes: [],
			valid_children: [FLOW_CONTENT].flatten,
			required_children: [],
			prohibited_explicitly: [
				HEADING_CONTENT, SECTIONING_CONTENT, :footer, :address
			].flatten,
			text_allowed: true, # REVIEW (exiquio)
			text_required: false,
			is_required: false,
			is_singleton: true, # REVIEW (exiquio)
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
			# FIXME: This require zero or more pairs of one dt element followed by
			#		one dd element. Hmm...? (exiquio)
			required_children: [], 
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
			text_required: false, # REVIEW (exiquio)
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
			text_required: false, # REVIEW (exiquio)
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
			text_required: false, # REVIEW (exiquio)
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	# TODO: Complete. (exiquio)
	# FIXME: Add tests. (exiquio)
	TEXT_LEVEL_SEMANTICS = {
		a: {
			valid_attributes: [
				'href', 'target', 'ping', 'rel', 'media', 'hreflang', 'type',
				GLOBAL_ATTRIBUTES
			].flatten,
			required_attributes: [], # REVIEW (exiquio)
			# The following is transparent. See Issues #6. (exiquio)
			valid_children: [],
			required_children: [],
			prohibited_explicitly: [INTERACTIVE_CONTENT].flatten,
			text_allowed: true,
			text_required: false,
			is_required: false,
			is_singleton: false,
			omit_end_tag: false
		}
	}

	VALID_ELEMENTS = [
		ROOT_ELEMENT,
		DOCUMENT_METADATA,
		SCRIPTING,
	  SECTIONS,
	  GROUPING_CONTENT
	].inject(:merge)

	# EXCEPTIONS

	# Generic Exception class to be thrown by BodyBuilder5 classes.
	class BodyBuilder5Exception < Exception
	end
end


# METHODS

# Returns a BodyBuilder5::HeMan5 object which represents a HTML5 documents
# with each of the tags/elments implemented as methods #tag, #tag_, and
# #_tag_ representing <tag>, </tag> and <tag></tag> respectively. Some tags
# do not have an end tag according to the HTML5 Draft and in such cases only
# the open method (#tag) is implemented. Otherwise expect all three. 
#
# These #tag and #_tag_ methods take a optional Hash argument containing the
# optional keys :attributes and :text which are both Strings in value.
#
# #Document is the prefered interface for creating HTML5 "documents" in
# BodyBuilder5.
#
# Example:
#
#		document = BodyBuilder5::Document
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


# Returns a BodyBuilder5::Skeletor5 object.
#
#	#Template is the prefered interfact for creating HTML5 "templates in
#	BodyBuilder5.
#
#	TODO: Complete documentation. (exiquio)
def Template
	BodyBuilder5::Skeletor5.new
end

# REVIEW: Review everything that is one to one with the HTML5 draft and ensure
#	 proper aherence to the letter of the law. (exiquio)
