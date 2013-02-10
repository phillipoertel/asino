# encoding: utf-8
# Account actually refers to a real bank account. It holds many items.
class Account < ActiveRecord::Base

  has_many :items, :order => 'created_at desc', :dependent => :destroy
  has_many :rulesets, :dependent => :destroy
  has_many :monthreports, :dependent => :destroy
  
  validates_presence_of :title, :message => "Bitte geben Sie dem Konto einen Namen!"
  validates_uniqueness_of :title, :message => "Dieser Kontoname wird bereits verwendet!"
  validates_inclusion_of :importer, in: AccountImporter::TYPES
  
  # HACK: reusing Saldomat's config field to store the outbank file name, as well.
  # when adding HBCI, change this to use store to store all config settings. it's the most flexible
  # way to store different attributes in an AR (see store docs here:
  # http://apidock.com/rails/ActiveRecord/Store) 
  def outbank_file_name
    self.feed
  end
  
  def import
    AccountImporter.import(self)
  end
end
