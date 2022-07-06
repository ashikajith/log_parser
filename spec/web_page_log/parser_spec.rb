# frozen_string_literal: true

RSpec.describe WebPageLog::Parser do
  describe "#perform" do
    context "for a valid log file" do
      subject do
        described_class.new("#{Dir.pwd}/spec/fixtures/test_data.log")
      end

      it "returns collection of records of WebPageLog::Visitor instance" do
        expect(subject.perform.records).to be_an_instance_of Array
        expect(subject.perform.records.first).to be_an_instance_of WebPageLog::Visitor
        expect(subject.perform.records.last).to be_an_instance_of WebPageLog::Visitor
      end

      it "returns the domain url path and the respective ip address of the visitor" do
        records = subject.perform.records
        expect(records.map(&:domain_path)).to eq(["/help_page/1", "/contact", "/home"])
        expect(records.map(&:ip_address)).to eq(["126.1.1", "184.123.1.1", "184.123.2.2"])
      end
    end

    context "for an empty log file" do
      subject do
        described_class.new("#{Dir.pwd}/spec/fixtures/empty_file.log")
      end

      it "returns an error message" do
        expect(subject.perform).to eq("Log file is empty")
      end
    end

    context "for an invalid log file" do
      subject do
        described_class.new("#{Dir.pwd}/spec/fixtures/invalid_file.log")
      end

      it "returns empty records" do
        expect(subject.perform.records).to be_empty
      end
    end
  end
end
