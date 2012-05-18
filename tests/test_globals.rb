# -*- encoding : utf-8 -*-

# test_globals.rb
#
# Global namespace for BodyBuilder5 tests.
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

# CONSTANTS
METADATA_CONTENT = [
	:title, :base, :link, :meta, :style, :script, :noscript, :command
]

FLOW_CONTENT = [
	:style, :script, :noscript, :section, :nav, :article, :aside, :h1, :h2, :h3,
	:h4, :h5, :h6, :header, :footer, :address, :p, :hr, :br, :pre, :dialog,
	:blockquote, :ol, :ul, :dl, :a, :q, :cite, :em, :strong, :small, :mark, :dfn,
	:abbr, :time, :progress, :meter, :code, :var, :samp, :kbd, :sub, :sup, :span,
	:i, :b, :bdo, :ruby, :ins, :del, :figure, :img, :iframe, :embed, :object,
	:video, :audio, :canvas, :map, :area, :table, :form, :fieldset, :label,
	:input, :button, :select, :datalist, :textarea, :output, :details, :command,
	:bb, :menu, :div
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
	:abbr, :time, :progress, :meter, :code, :var, :samp, :kbd, :sub, :sup, :span,
	:i, :b, :bdo, :ruby, :ins, :del, :img, :iframe, :embed, :object, :video,
	:audio, :canvas, :area, :label, :input, :button, :select, :datalist,
	:textarea, :output, :command, :bb
]

EMBEDDED_CONTENT = [
	:img, :iframe, :embed, :object, :video, :audio, :canvas
]

INTERACTIVE_CONTENT = [
	:a, :img, :video, :audio, :label, :input, :button, :select, :textarea,
	:details, :bb, :menu
]

HTML5_ELEMENTS = [
	# Root Element
	:html,
	# Document Metadata
	:head, :title, :base, :link, :meta, :style,
	# Scripting
	:script, :noscript,
	# Sections
	:body, :section, :nav, :article, :aside, :h1, :h2, :h3, :h4, :h5, :h6,
	:header, :footer, :address,
	# Grouping Content
	:p, :hr, :br, :pre, :dialog, :blockquote, :ol, :ul, :li, :dl, :dt, :dd,
	# Text-Level Semantics
	:a, :q, :cite, :em, :strong, :small, :mark, :dfn, :abbr, :time, :progress,
	:meter, :code, :var, :samp, :kbd, :sub, :sup, :span, :i, :b, :bdo, :ruby,
	:rt, :rp,
	# Edits
	:ins, :del,
	# Embedded Content
	:figure, :img, :iframe, :embed, :object, :param, :video, :audio, :source,
	:canvas, :map, :area,
	# Tabular Content
	:table, :caption, :colgroup, :col, :tbody, :thead, :tfoot, :tr, :td, :th,
	# Forms
	:form, :fieldset, :label, :input, :button, :select, :datalist, :optgroup,
	:option, :textarea, :output,
	# Interactive Content
	:details, :command, :bb, :menu,
	# Miscellaneous Elements
	:legend, :div
]

TAG_PROPERTIES = [
	{name: :attributes, type: [Array]},
	{name: :required_attributes, type: [Array]},
	{name: :content_model, type: [Array]},
	{name: :required_content, type: [Array]},
	{name: :prohibited_explicitly, type: [Array]},
	{name: :text_allowed, type: [TrueClass, FalseClass]},
	{name: :text_required, type: [TrueClass, FalseClass]},
	{name: :is_required, type: [TrueClass, FalseClass]},
	{name: :is_singleton, type: [TrueClass, FalseClass]},
	{name: :omit_end_tag, type: [TrueClass, FalseClass]}
]

DIV_ATTRIBUTES, P_TEXT = 'id="text"', 'Pardon my Swahili.'
RENDER_SNIPPET = '<p>Pardon my Swahili.'
ELEMENT_TO_S = 'Element[p -> parent: Element[div -> parent: , children: [], ' +
	'attributes: id="text" text: ], children: [], attributes:  text: Pardon ' +
	'my Swahili.]'
HTML5_DOCUMENT = '<!doctype html><html><head><title>Test Document</title>' +
	'</head><body><div id="content"><p>This is a test</p></div></body></html>'


