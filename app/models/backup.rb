require 'fileutils'

class Backup < ActiveRecord::Base
  
  before_create :create_backup_file
  
  private
  
    def create_backup_file
      conf      = Rails.configuration.database_configuration[Rails.env]
      file_name = "asino_backup_#{Rails.env}_#{Time.now.strftime('%Y%m%d%H%M%S')}.sql"
      path      = Asino3::Application.config.backup_dir
      FileUtils.mkdir_p(path) unless File.exist?(path)
      backup_file = File.join(path, file_name)
      
      cmd = "mysqldump --user=%s --password=%s --database %s > %s" % [conf['username'], conf['password'], conf['database'], backup_file]
      
      Rails.logger.debug(cmd)
      system(cmd)
      raise "Creating the backup failed" unless $? == 0
      
      self.file_name = file_name
    end
    
end
