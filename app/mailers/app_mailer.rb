class AppMailer < ApplicationMailer

  def invite_mail(user_sender, user_mail)
    @user = user_sender
    mail(to: user_mail, subject: '¡Te han invitado a probar VeloExpress!')
  end

  def confirm(delivery)
    @delivery = delivery
    mail(to: delivery.destinatary_email, subject: 'Confirmación de recepción del envío')
  end

  #registro bienvenido
  def welcome(user)
    mail(to: user.email, subject: 'Bienvenido a Velo Express')
  end

  #felicitaciones (activar cuenta)
  def activated_acc(user)
    mail(to: user.email, subject: '¡Tu cuenta ha sido activada!')
  end

  #desactivado (desactivar cuenta)
  def deactivated_acc(user)
    mail(to: user.email, subject: '¡Tu cuenta ha sido desactivada!')
  end

  def recover_password(user)
    @user = user
    mail(to: user.email, subject: 'Recupera tu contraseña')
  end

end
