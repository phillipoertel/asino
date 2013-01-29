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
  
  # when an rss_file is given, parse that, else fetch the feed. That's useful for testing.
  def import_from_feed(feed_file = nil)
    file = open(feed_file || self.feed)
    return unless file
    feed = Feedzirra::Feed.parse(file.read)
    puts "got feed for account #{self.id}: #{self.feed}"
    puts feed.entries.size
    feed.entries.each do |entry|
      puts "title: #{entry.title}"
      puts "amount: #{entry.title.sanitize.split(' - ')[0]}"
      next if entry.title.sanitize.split(' - ').class != Array
      next if Item.exists?(:uid => entry.id) # that would have been nice. but looks like the uid in the feed changes
      # so we check for duplicates by content. Not good for items that are really the same
      next if Item.exists?(:amount => entry.title.force_encoding("UTF-8").sanitize.split(' - ')[0].gsub('.','').gsub(',','.').to_f,
                            :created_at => entry.updated.to_date,:account_id => self.id,
                            :payee => entry.title.sanitize.split(' - ')[1],
                            :description => entry.title.sanitize.split(' - ')[2])
      puts "adding #{entry.title.split(' - ')[1]}"
      puts "    date: #{entry.updated}"
      Item.create({:uid => entry.id, 
                   :created_at => entry.updated.to_date,
                   :account_id => self.id,
                   :amount => entry.title.sanitize.split(' - ')[0].gsub('.','').gsub(',','.').to_f,
                   :payee => entry.title.sanitize.split(' - ')[1],
                   :description => entry.title.sanitize.split(' - ')[2]})
    end
  end
end
