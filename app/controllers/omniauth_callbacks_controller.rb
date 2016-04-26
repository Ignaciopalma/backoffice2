	class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @sender = Sender.find_for_oauth(env["omniauth.auth"], current_sender)

        if @sender.persisted?
          sign_in_and_redirect @sender, event: :authentication
          set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_sender_registration_url
        end
      end
    }
  end

  [:facebook].each do |provider|
    provides_callback_for provider
  end

end

