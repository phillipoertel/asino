# Used basically only to restrict access to account information.
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  
  # returns if the last backup is too long ago
  def should_backup?
    last_backup = Backup.order("created_at desc").first
    return true unless last_backup
    should_backup = (Time.now - last_backup.created_at > 24.hours)
  end
end
