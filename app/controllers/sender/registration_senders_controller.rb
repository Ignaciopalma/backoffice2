class RegistrationSendersController < Devise::RegistrationsController

  protected
    def sign_up_params
      params.require(:sender).permit(Sender.allowed_attributes)
    end
end
