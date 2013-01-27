class CreateBackups < ActiveRecord::Migration
  def self.up
    create_table :backups do |t|
      t.string :file_name
  
      t.timestamps
    end
  end

  def self.down
    drop_table :backups
  end
end
