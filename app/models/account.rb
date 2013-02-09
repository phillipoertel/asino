# encoding: utf-8
# Account actually refers to a real bank account. It holds many items.
class Account < ActiveRecord::Base

  has_many :items, :order => 'created_at desc', :dependent => :destroy
  has_many :rulesets, :dependent => :destroy
  has_many :monthreports, :dependent => :destroy
  
  validates_presence_of :title, :message => "Bitte geben Sie dem Konto einen Namen!"
  validates_uniqueness_of :title, :message => "Dieser Kontoname wird bereits verwendet!"
  validates_inclusion_of :importer, in: AccountImporter::TYPES
  
  # HACK -- reusing saldomat's field to store the outbank file
  def outbank_file_name
    self.feed
  end
  
  def import
    import_class = AccountImporter.for(self.importer)
    import_class.new(self).import
  end
end
