class AddImporterToAccount < ActiveRecord::Migration
  def up
    add_column :accounts, :importer, :string, default: 'Saldomat'
    Account.update_all("importer='Saldomat'")
  end
  
  def down
    remove_column :accounts, :importer
  end
end
