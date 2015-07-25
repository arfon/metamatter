require_relative 'helper'

describe Metamatter do

  subject { Metamatter::Repository.new('arfon/metamatter') }

  it "knows what it's name and owner is" do
    expect(subject.name_with_owner).to eql('arfon/metamatter')
    expect(subject.owner).to eql('arfon')
    expect(subject.name).to eql('metamatter')
  end
end
