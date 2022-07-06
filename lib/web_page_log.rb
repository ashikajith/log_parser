# frozen_string_literal: true

require "pry"
require_relative "web_page_log/version"
require_relative "web_page_log/parser"
require_relative "web_page_log/visitor"
require_relative "web_page_log/visitor_collection"

# binding.pry
# WebPageLog::Parser.new('data/webserver.log').perform
