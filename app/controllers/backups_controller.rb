class BackupsController < ApplicationController

  def index
    @backups = Backup.order('created_at desc')
    if user_signed_in? and current_user.should_backup?
      flash[:alert] = "Sie sollten eine Sicherung Ihrer Daten anlegen, jetzt!" 
    end
    
    if mysqldump_installed?
      @button_enabled = true
    else
      flash[:alert] = "Bitte installieren sie mysqldump, um Backups anzulegen." 
      @button_enabled = false
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @backups }
    end
  end
  
  def create
    Backup.create!
    redirect_to(backups_path, :notice => 'Sicherung wurde erfolgreich gespeichert.')
  rescue
    redirect_to(backups_path, :alert => 'Sicherung wurde NICHT gespeichert!')
  end
  
  private
  
    def mysqldump_installed?
      system("command -v mysqldump > /dev/null")
      # $? is the return value of the last system call, 0 means "all fine" in unix lingo.
      $? == 0
    end
end
