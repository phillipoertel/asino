class AccountImporter::Outbank
  
  MAPPING = {
    # outbank line attribute => item attribute
    :unique_id => :uid,
    :booked_on => :created_at,
    :description => :description
  }
  
  def initialize(account, options = {})
    @account_id = account.id
    @lines = Outbanker::StatementLines.read(account.outbank_file_name)
  end
  
  def import!
    
    @lines.each do |entry|
      
      if Item.exists?(:uid => entry.unique_id)
        Rails.logger.debug("Skipping #{entry}, it already exists")
        next
      else
        Rails.logger.debug("Adding #{entry}")
        create_item(entry)
      end      

    end
  end

  private
  
    def create_item(entry)
      attributes = {}
      attributes[:account_id]  = @account_id
      attributes[:uid]         = entry.unique_id
      attributes[:created_at]  = entry.booked_on
      attributes[:description] = entry.description
      attributes[:amount]      = entry.amount.to_f / 100
      Item.create!(attributes)
    end
    
end
