class WebPageLog::VisitorCollection
  include Enumerable

  attr_accessor :records

  def initialize
    @records = []
  end

  def add_view_path(**visitor_hash)
    records << WebPageLog::Visitor.new(**visitor_hash)
  end

  def total_page_views
    group_by_visitor_count = {}
    group_by_domain_path_url.each do |key, visitor_ary|
      group_by_visitor_count[key] = visitor_ary.map(&:ip_address).count
    end
    grouped_hash = group_by_visitor_count.sort_by { |key, count| -count }.to_h
    log_formatter(grouped_hash)
  end

  def total_uniq_page_views
    group_by_visitor_count = {}
    group_by_domain_path_url.each do |key, visitor_ary|
      group_by_visitor_count[key] = visitor_ary.map(&:ip_address).uniq.count
    end
    grouped_hash = group_by_visitor_count.sort_by { |key, count| -count }.to_h
    log_formatter(grouped_hash, uniq: true)
  end

  private

  def group_by_domain_path_url
    records.group_by { |visitor| visitor.domain_path }
  end

  def log_formatter(grouped_hash, uniq: false)
    grouped_hash.each do |domain_name, visit_count|
      str = "#{domain_name} #{visit_count}"
      str += " unique" if uniq
      puts "#{str} visits"
    end
  end
end