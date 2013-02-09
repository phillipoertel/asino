require 'spec_helper'

describe AccountImporter do
  it "returns the correct importer class" do
    AccountImporter.for('Saldomat').should == AccountImporter::Saldomat
    AccountImporter.for('HBCI').should == AccountImporter::HBCI
  end
  
  it "delegates importing to an import class" do
    AccountImporter::Saldomat.any_instance.should_receive(:import)
    account = Account.new(:importer => 'Saldomat', :id => 42)
    account.import
  end
end