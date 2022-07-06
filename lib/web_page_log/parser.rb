# frozen_string_literal: true

module WebPageLog
  # Class to parse the log file and extract the logs to respective objects
  class Parser
    attr_reader :document

    def initialize(document)
      @document = document
    end

    def perform
      return "Log file is empty" if File.empty?(document)

      collection = WebPageLog::VisitorCollection.new
      File.foreach(document) do |line|
        domain_path, ip_address = line.split((" "))
        next if [domain_path, ip_address].any? { |ele| ele.nil? || ele.empty? }

        collection.add_view_path(domain_path: domain_path, ip_address: ip_address)
      end
      collection
    end
  end
end
