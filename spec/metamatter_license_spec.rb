require_relative 'spec_helper'

describe Metamatter::License do
  subject(:repository) { Metamatter::Repository.new('arfon/metamatter') }
  subject(:license) { Metamatter::License.new(repository) }

  it "can detect the license" do
    VCR.use_cassette('license') do
      expect(license.has_license?).to be true
    end
  end

  it "can returns the license hash" do
    VCR.use_cassette('license') do
      expect(license.license[:name]).to eql('MIT License')
    end
  end
end
