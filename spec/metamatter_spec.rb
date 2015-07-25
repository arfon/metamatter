require_relative 'spec_helper'

describe Metamatter do

  subject { Metamatter::Repository.new('arfon/metamatter') }

  it "abstracts numbers" do
    expect(subject.name_with_owner).to eql('arfon/metamatter')
  end
end
