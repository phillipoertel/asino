class AccountImporter::Saldomat
  
  require 'rss/2.0'
  require 'open-uri'
  require 'date'

  def initialize(account)
    @account_id = account.id
    @feed       = account.feed
  end
  
  def import
    
    feed_entries.each do |entry|
      
      puts "title: #{entry.title}"
      puts "amount: #{entry.title.sanitize.split(' - ')[0]}"
      
      next if entry.title.sanitize.split(' - ').class != Array

      # that would have been nice. but looks like the uid in the feed changes
      next if Item.exists?(:uid => entry.id)
      
      # so we check for duplicates by content. Not good for items that are really the same
      next if Item.exists?(
        :amount => entry.title.force_encoding("UTF-8").sanitize.split(' - ')[0].gsub('.','').gsub(',','.').to_f,
        :created_at => entry.updated.to_date,:account_id => @account_id,
        :payee => entry.title.sanitize.split(' - ')[1],
        :description => entry.title.sanitize.split(' - ')[2])
                            
      puts "adding #{entry.title.split(' - ')[1]}"
      puts "    date: #{entry.updated}"
      
      Item.create({
        :uid => entry.id, 
        :created_at => entry.updated.to_date.to_datetime + 12.hours,
        :account_id => @account_id,
        :amount => entry.title.sanitize.split(' - ')[0].gsub('.','').gsub(',','.').to_f,
        :payee => entry.title.sanitize.split(' - ')[1],
        :description => entry.title.sanitize.split(' - ')[2]
      })
    end
  end
  
  private 
  
    def feed_entries
      Feedzirra::Feed.parse(open(@feed).read).entries
    end
  
end
