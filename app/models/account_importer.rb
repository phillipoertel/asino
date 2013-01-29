module AccountImporter
  def self.for(type)
    "AccountImporter::#{type}".constantize
  end
end