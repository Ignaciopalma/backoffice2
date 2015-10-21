class RecoverPasswordJob < Struct.new(:email)
	def perform
		user = User.find_by_email(email)
		user.recover_password_token = nil
		user.save
	end
end