module AccountImporter
  
  TYPES = %w(Saldomat HBCI Outbank)
  
  class << self
  
    # find the importer for the account source type, instantiate and run it.
    def import(account)
      klass = self.for(account.importer)
      klass.new(account).import
    end
    
    def for(type)
      "AccountImporter::#{type}".constantize
    end
    
  end
    
end