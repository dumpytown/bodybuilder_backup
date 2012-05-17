# -*- encoding : utf-8 -*-

# object.rb
#
# (C) Copyright 2012 Exiquio Cooper-Anderson, Stephen Meyers
#
# GPLv3 (www.gnu.org/licenses/gpl.html)
#
# Author(s):
#		Exiquio Cooper-Anderson (exiquio@gmail.com)
#		Stephen Meyers (?@?.com)

# Global Object and namespace.
class Object
	public

	# Returns true if instance is of TrueClass or FalseClass and false if not.
	#
	#	=== Parameters:
	#	* None
	#
	# === Returns:
	# * TrueClass || FalseClass
	#
	# === Example:
	#		'html'.is_boolean? # false
	#		true.is_boolean? # true
	def is_boolean?
		[TrueClass, FalseClass].include? self.class
	end

	# Returns true if arguments include the class of instance, false if not.
	#
	# === Parameters:
	# *	+*args+ - (Class) [Required, ...Optional] Classes to be checked against
	#			object's class.
	#
	# === Returns:
	#	* TruthClass || FalseClass
	#
	# === Example:
	#		'html'.is_one_of?(NilClass, Array) # false
	#		1.is_one_of?(Fixnum, String, Hash) # true
	def is_one_of? *args
		raise(
			ArgumentError,
			'At least one Class must be provided'
		) unless args.length >= 1

		args.each do |arg|
			raise ArgumentError, '*args must be Classes' unless arg.is_a? Class
		end

		args.include?(self.class)
	end
end


# FIXME: Refactor as BodyBuilder5 classes. (exiquio)

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
# === Paramaters:
# * None
#
# === Returns:
# * HeMan5 Instance.
#
# === Example:
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
# Prefered constructor for creating a new BodyBuilder5::Skeletor5.
#
# === Parameters:
# * TODO:
#
# === Returns:
# * Skeletor5 Instance.
def Template
	BodyBuilder5::Skeletor5.new
end
