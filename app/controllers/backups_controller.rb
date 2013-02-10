class BackupsController < ApplicationController

  before_filter :load_accounts, :only => [:index]
  
  def index
    @backups = Backup.order('created_at desc')
    
    flash[:alert] = "Sie sollten eine Sicherung Ihrer Daten anlegen, jetzt!" if user_signed_in? and current_user.should_backup?

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @backups }
    end
  end
  
  def create
    conf = Rails.configuration.database_configuration[Rails.env]

    backup = Backup.new(params[:backup])
    file_name = "asino_backup_#{Time.now.strftime('%Y%m%d%H%M%S')}.sql"
    path = Asino3::Application.config.backup_dir
    Rails.logger.debug "mysqldump --user=#{conf['username']} --password=#{conf['dpassword']} --database #{conf['database']} > #{path}/#{file_name}"
    result = system "mysqldump --user=#{conf['username']} --password=#{conf['dpassword']} --database #{conf['database']} > #{path}/#{file_name}"
    backup.file_name = file_name

    respond_to do |format|
      if result and backup.save
        format.html { redirect_to(backups_path, :notice => 'Sicherung wurde erfolgreich gespeichert.') }
      else
        format.html { redirect_to(backups_path, :alert => 'Sicherung wurde NICHT gespeichert!') }
      end
    end
  end
end
