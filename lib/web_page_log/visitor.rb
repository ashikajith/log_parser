# frozen_string_literal: true

module WebPageLog
  # Class to save the each line of the server log to an entity
  class Visitor
    attr_reader :domain_path, :ip_address

    def initialize(domain_path:, ip_address:)
      @domain_path = domain_path
      @ip_address = ip_address
    end
  end
end
