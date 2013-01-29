class AccountImporter::HBCI
  
  def initialize(options = {})
    @account_id = options[:account_id]
  end  
  
  def import!
    "Hello from the HBCI Account importer ..."
  end
  
end
