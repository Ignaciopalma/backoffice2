class Sender < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
          :rememberable, :trackable, :validatable, :omniauthable,omniauth_providers: [:facebook]



  belongs_to :area
  belongs_to :city
  has_many :deliveries
  has_many :identities, dependent: :destroy

  #validates_inclusion_of :pay_day, :in => 1..31


  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and sender if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing sender
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    sender = signed_in_resource ? signed_in_resource : identity.sender

    # Create the sender if needed
    if sender.nil?

      # Get the existing sender by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # sender to verify it on the next step via sendersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      sender = sender.where(email: email).first if email

      # Create the sender if it's a new registration
      if sender.nil?
        if identity.provider == "twitter"
            sender = Sender.new(
              contact_name: auth.info.name,
              email: email ? email : "update@me.com",
              #remote_avatar_url: auth.info.image,
              password: Devise.friendly_token[0,20]
            )
          else
            sender = Sender.new(
              contact_name: auth.info.name,
              email: email ? email : "update@me.com",
              #remote_avatar_url: auth.info.image,
              password: Devise.friendly_token[0,20]
            )
          end
        sender.save!
      end
    end

    # Associate the identity with the sender if needed
    unless identity.sender == sender
      identity.sender = sender
      identity.save!
    end
    sender
  end

end
