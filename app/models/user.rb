require './lib/repository'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include ActiveModel::Validations

  belongs_to :craftsman
  before_create :associate_craftsman

  validate :password_complexity
  def password_complexity
    if password.present?
      if !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*\-+;:'"])/)
        errors.add :password, "must have a number, lowercase, uppercase and special character"
      end
    end
  end

  def associate_craftsman
    craftsman = Craftsman.find_by_email(self.email) || Craftsman.all.sample
    self.craftsman_id = craftsman.employment_id if craftsman
  end

  private

  def self.find_or_create_by_auth_hash(hash)
    if user = User.find_by_uid(hash['uid'])
      return user
    end

    user = User.new
    user.email = user.login = hash['info']['email']
    user.uid = hash['uid']
    user.provider = hash['provider']
    user.save!
    user
  end
end
