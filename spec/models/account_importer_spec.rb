require 'spec_helper'

describe AccountImporter do
  it "returns the correct importer class" do
    AccountImporter.for('Saldomat').should == AccountImporter::Saldomat
    AccountImporter.for('HBCI').should == AccountImporter::HBCI
  end
end