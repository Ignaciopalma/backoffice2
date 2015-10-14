class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session

  def options
    head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'
  end


  def calculate_pay_date sender_pay_day
    sender_pay_day_local = 1
    if sender_pay_day != 0
      sender_pay_day_local = sender_pay_day
    end

    if Date.today.next_month.end_of_month.day >= sender_pay_day_local #si el dia de pago esta correcto y no pasado
      return DateTime.new(Date.today.year, Date.today.next_month.month, sender_pay_day_local)
    else
      return DateTime.new(Date.today.year, Date.today.next_month.month, Date.today.next_month.end_of_month.day)
    end

  end
end
