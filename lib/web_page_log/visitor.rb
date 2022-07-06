class WebPageLog::Visitor
  attr_reader :domain_path, :ip_address

  def initialize(domain_path:, ip_address:)
    @domain_path = domain_path
    @ip_address = ip_address
  end
end