class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    # return nil unless email is an officer/developer
    if Officer.where("email = ?", email).empty? && !['anuj@anujinfotech.com', 'amg9973@tamu.edu', 'phelan27@tamu.edu', 'brentonlenzen@tamu.edu', 'jlee232435@tamu.edu'].include?(email)
      return nil
    end
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end
end
