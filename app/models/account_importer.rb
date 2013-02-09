module AccountImporter
  
  TYPES = %w(Saldomat HBCI Outbank)
  
  def self.for(type)
    "AccountImporter::#{type}".constantize
  end
end