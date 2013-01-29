require 'spec_helper'

describe Account do

  before(:all) { Account.observers.disable :all }
  after(:all)  { Account.observers.enable :all }
  
  def assert_attributes(item, expectations)
    item.amount.to_f.should == expectations.delete(:amount)
    expectations.each { |attr, value| item.send(attr).should == value }
  end
  
  def import!
    Item.any_instance.stub(:add_to_monthreport).and_return(true)
    Account.new.import_from_feed('test/fixtures/saldomat.rss')
    Item.all
  end
    
  it "should have a valid factory" do
    FactoryGirl.build(:account).should be_valid
  end
  
  it "imports the data correctly" do
    items = import!
    items.count.should == 3
    assert_attributes(items[0], {
      amount: -42.42,
      payee: "548792/001/ 230576.0001",
      description: "LECKER WEIN",
      uid: "F0C951D8-1201-4BD6-B161-5625FD302A87"
    })
    assert_attributes(items[1], {
      amount: 53.0,
      payee: "Scheckeinreichung",
      description: "SCHECK-EINREICHUNG",
      uid: "4F8902EC-F67A-4324-AF74-66B520F5D509"
    })
    assert_attributes(items[2], {
      amount: -25,
      payee: "Dauerauftrag an",
      description: "Menschen fuer Menschen",
      uid: "1287F435-6AA3-4CCF-A42D-210B43717615"
    })
  end
  
end