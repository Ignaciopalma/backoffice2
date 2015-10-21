class Api::SessionController < Api::ApiController
  before_action :authenticate, only: [:destroy]


  respond_to :json

  def create
    respond_to do |format|
      if session_params[:email] != nil &&  session_params[:password] != nil
        user = User.find_by(email: session_params[:email].downcase)
        if user.present? && user.authenticate(session_params)
          if user.active == 0
            format.json { render :json =>  {:msg => "La cuenta no ha sido activada"}, status: :unprocessable_entity }
          else
            user.api_key = user.generate_api_key
            user.save
            format.json { render :json => user, status: :ok }
          end

        else
          format.json { render :json =>  {:msg => "Usuario o contraseña incorrecto"}, status: :unauthorized }
        end
      else
        format.json { render :json =>  {:msg => "No se reciben las credenciales"}, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      @user.destroy_session
      format.json { render :json => "Te has desconectado correctamente",  status: :ok}
      @user = nil
    end
  end

  def isLogged
    respond_to do |format|
      user = User.find_by_api_key(session_params[:api_key])
      if user.present?
        format.json { render :json => user,  status: :ok}
      else
        format.json { render :json => {:msg => "No está autenticado"},  status: :unauthorized}
      end
    end
  end

  def get_banks
    respond_to do |format|
      format.json { render :json => Bank.all, status: :ok}
    end
  end

  def get_account_types
    respond_to do |format|
      format.json { render :json => AccountType.all, status: :ok}
    end
  end

  def get_occupations
    respond_to do |format|
      format.json { render :json => Occupation.all, status: :ok}
    end
  end

  def get_confirmed_deliveries
    user = User.find_by_api_key(session_params[:api_key])
    respond_to do |format|
      format.json { render :json => {:deliveries => user.deliveries.where(:confirmed => 1).count}, status: :ok}
    end
  end

  def update_user
    user = User.find_by_api_key(session_params[:api_key])
    original_user = User.find_by_api_key(session_params[:api_key])
    if user.present?
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user][:password] = user.password
        params[:user][:password_confirmation] = user.password
      end
      respond_to do |format|
        if user.update(user_params)
          format.json { render :json => user, status: :ok }
        else
          format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"}, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"}, status: :unprocessable_entity }
      end
    end
  end

  def register_user
    user = User.new(user_params)

    respond_to do |format|
      if user.save
        AppMailer.welcome(user).deliver_later
        format.json { render :json => {:msg => "Te has registrado exitosamente, te llegará un correo electrónico confirmando tu registro"}, status: :ok}
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"}, status: :unprocessable_entity }
      end
    end
  end

  def invite_friend
    user = User.find_by_api_key(session_params[:api_key])
    respond_to do |format|
      if user.present?
        AppMailer.invite_mail(user, params[:invited_friend]).deliver_later
        format.json { render :json => {:msg => "Se ha enviado la invitación exitosamente"}, status: :ok}
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"}, status: :unprocessable_entity }
      end
    end
  end

  def update_position
    user = User.find_by_api_key(session_params[:api_key])
    respond_to do |format|
      if user.present?
        user.lon = params[:lon]
        user.lat = params[:lat]
        if user.save
          format.json { render :json => {}, status: :ok}
        else
          format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"}, status: :unprocessable_entity }
        end
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"}, status: :unprocessable_entity }
      end
    end
  end

  def create_problem
    user = User.find_by_api_key(session_params[:api_key])
    params[:problem][:user_id] = user.id
    problem = Problem.new(problem_params)
    respond_to do |format|
      if user.present? and problem.save
        format.json { render :json => {:msg => "Se ha enviado el mensaje exitosamente"}, status: :ok}
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"}, status: :unprocessable_entity }
      end
    end
  end

  def recover_password
    user = User.find_by_email(params[:email]) rescue nil
    respond_to do |format|
      if user.present?
        #generar token
        user.recover_password_token = (0...50).map { ('a'..'z').to_a[rand(26)] }.join
        user.save

        #enviar mail
        AppMailer.recover_password(user).deliver_later

        #encolar el borrado
        ::Delayed::Job.enqueue(::RecoverPasswordJob.new(params[:email]), {:priority => 100, :run_at => 60.minutes.from_now})

        format.json { render :json => {:msg => "Se ha enviado un correo electrónico con las instrucciones"},  status: :ok}
      else
        format.json { render :json => {:msg => "No se encontró el usuario asiciado al correo electrónico"},  status: :unprocessable_entity}
      end
    end
  end

  def recover

  end

  def do_recover

    if params[:pass1] != params[:pass2] or params[:token].nil? or params[:token] == nil or params[:pass1] == nil or params[:pass2] == nil
      flash[:notice] = "Ocurrió un error"
      redirect_to "/api/recover/"+params[:token]
      return
    end

    user = User.find_by_recover_password_token(params[:token])

    if user.blank?
      flash[:notice] = "Ocurrió un error"
      redirect_to "/api/recover/"+params[:token]
      return
    else
      flash[:notice] = "Ha cambiado su contraseña exitosamente"
      user.password = params[:pass1]
      user.recover_password_token = nil
      user.save

      redirect_to "/api/recover/"+params[:token]
      return

    end
  end


  private

  def session_params
    params.require(:session).permit(:email, :password, :api_key)
  end

  def user_params
    params.require(:user).permit(:account_number, :account_type_id, :address, :bank_id, :email, :first_name, :last_name, :occupation_detail, :occupation_id, :phone, :rut, :password, :password_confirmation)
  end

  def problem_params
    params.require(:problem).permit(:user_id, :content)
  end

end
