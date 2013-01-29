class AccountImporter::HBCI
  
  def initialize(account_id)
    @account_id = account_id
  end  
  
  def import!
    "Hello from the HBCI Account importer ..."
  end
  
end
