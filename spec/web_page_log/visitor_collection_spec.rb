# frozen_string_literal: true

RSpec.describe WebPageLog::VisitorCollection do
  let(:server_log_hash) do
    [
      ["/help_page/1", "126.1.1"],
      ["/contact", "184.123.1.1"],
      ["/help_page/1", "126.2.1"],
      ["/help_page/1", "126.1.1"],
      ["/about", "336.284.013.698"],
      ["/home", "184.123.2.2"],
      ["/help_page/1", "802.1.1.780"],
      ["/about", "336.284.013.698"],
      ["/contact", "158.577.775.616"]
    ]
  end
  let(:visitor_collection) do
    server_log_hash.map do |visitor_ary|
      WebPageLog::Visitor.new(domain_path: visitor_ary[0], ip_address: visitor_ary[1])
    end
  end
  let(:subject) { described_class.new }

  describe "#total_page_views" do
    it "returns records grouping the domain path with the number of visitors count" do
      subject.records = visitor_collection
      expect(subject.total_page_views).to eq(
        log_formatter({
                        "/help_page/1" => 4,
                        "/contact" => 2,
                        "/about" => 2,
                        "/home" => 1
                      })
      )
    end

    it "returns empty records if no visitors are logged" do
      expect(subject.total_page_views).to be_empty
    end
  end

  describe "#total_uniq_page_views" do
    it "returns records grouping the domain path with the unique number of visitors count" do
      subject.records = visitor_collection
      expect(subject.total_uniq_page_views).to eq(
        log_formatter({
                        "/help_page/1" => 3,
                        "/contact" => 2,
                        "/home" => 1,
                        "/about" => 1
                      }, uniq: true)
      )
    end

    it "returns empty records if no visitors are logged" do
      expect(subject.total_uniq_page_views).to be_empty
    end
  end

  def log_formatter(hash, uniq: false)
    hash.each do |domain_name, visit_count|
      str = "#{domain_name} #{visit_count}"
      str += "unique" if uniq
      puts "#{str} visits"
    end
  end
end
