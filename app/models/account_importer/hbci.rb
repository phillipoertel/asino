class AccountImporter::HBCI
  
  def initialize(account, options = {})
    @account_id = account.id
  end  
  
  def import!
    "Hello from the HBCI Account importer ..."
  end
  
end
