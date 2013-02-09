class AccountImporter::Outbank
  
  def initialize(account)
    @account_id = account.id
    @lines = Outbanker::StatementLines.read(account.outbank_file_name)
  end
  
  def import
    
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
  
    def mapped_attributes(entry)
      attributes = {}
      attributes[:account_id]  = @account_id
      attributes[:uid]         = entry.unique_id
      attributes[:created_at]  = entry.booked_on
      attributes[:description] = entry.description
      attributes[:amount]      = entry.amount.to_f / 100
      attributes
    end
    
    def create_item(entry)
      attributes = mapped_attributes(entry)
      Item.create!(attributes)
    end
    
end
