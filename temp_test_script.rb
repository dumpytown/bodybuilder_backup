#!/usr/bin/env ruby

# The following code works now without validation features:

require_relative 'lib/bodybuilder5'

document = BodyBuilder5::HeMan5.new

document.html
	document.head
		document._title_ text: 'Bush4Prez'
	document.head_
	document.body
		document.div attributes: 'id="content"'
			document._p_ text: 'Give me Bush or give me death!'
		document.div_
	document.body_
document.html_

puts document.render

=begin
# This will soon be something akin to:

Document.parse do
	html
		head
			_title_ text: 'Bush4Prez'
		head_
		body
			div attributes: 'id="content"'
				_p_ text: 'Give me Bush or give me death~'
			div_
		body_
	html_
end

# Document.load will come into play too.
=end
