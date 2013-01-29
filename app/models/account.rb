# encoding: utf-8
# Account actually refers to a real bank account. It holds many items.
class Account < ActiveRecord::Base

  require 'rss/2.0'
  require 'open-uri'
  require 'date'

  has_many :items, :order => 'created_at desc', :dependent => :destroy
  has_many :rulesets, :dependent => :destroy
  has_many :monthreports, :dependent => :destroy
  
  validates_presence_of :title, :message => "Bitte geben Sie dem Konto einen Namen!"
  validates_uniqueness_of :title, :message => "Dieser Kontoname wird bereits verwendet!"
  validates_inclusion_of :importer, in: %w(Saldomat HBCI)
  
  def import_from_feed(feed_file = nil)
    importer = AccountImporter.for(self.importer)
    options = {
      # when an rss_file is given, parse that, else fetch the feed. That's useful for testing.
      # FIXME this will move to AccountImporter::Saldomat
      feed_file: open(feed_file || self.feed),
      account_id: self.id
    }
    importer.new(options).import!
  end
end
