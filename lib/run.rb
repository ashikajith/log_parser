# frozen_string_literal: true

require_relative "./web_page_log"

collection = WebPageLog::Parser.new("data/webserver.log").perform

puts "Total visits by each domain path"
collection.total_page_views
puts "---------------------------------------"
puts "Total unique visits by each domain path"
collection.total_uniq_page_views
