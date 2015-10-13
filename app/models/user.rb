class User < ActiveRecord::Base
    rolify

    before_create do |doc|
                doc.api_key = doc.generate_api_key
    end

    before_save { self.email = email.downcase }

    validates :first_name,  presence: true, length: { maximum: 50 }
    validates :last_name,  presence: true, length: { maximum: 50 }
    validates :rut,  presence: true, length: { maximum: 10 }
    validates :phone, :rut, :address, :occupation_id, :bank_id, :account_type_id,:account_number, presence: true



    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }


    #has_secure_password
    validates :password, length: { minimum: 8 }
    validates :password, confirmation: true

    has_many :deliveries
    belongs_to :bank
    belongs_to :occupation
    belongs_to :account_type

  # Returns the hash digest of the given string.
    #def User.digest(string)
    #            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    #                                                                                            BCrypt::Engine.cost
    #            BCrypt::Password.create(string, cost: cost)
    #end

    def destroy_session
            self.api_key = ''
            self.save
    end

    def generate_api_key
                loop do
                        token = SecureRandom.base64.tr('+/=', 'Qrt')
                        break token unless User.exists?(api_key: token)
                end
    end

    #params: { email, password}
    def authenticate (params)
            if params.has_key? :password
                        user = User.find_by_email params[:email].downcase
                        if user and user.password == params[:password]
                            true
                        else
                            false
                        end
            else
                        false
            end
    end

    def set_admin_role
                self.add_role :admin
    end

    def set_cyclist_role
                self.add_role :cyclist
    end

    def set_sender_role
                self.add_role :sender
    end

end
