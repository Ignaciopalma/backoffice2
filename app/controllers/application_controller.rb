class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session

    def options
            head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'
    end

  def calculate_pay_date sender_pay_day, default
    if sender_pay_day != 0
      if Date.today.day < sender_pay_day #no estoy pasado, me quedo en el mismo mes
        if Date.today.end_of_month.day >= sender_pay_day  #si el dia de pago esta correcto y no pasado
          return DateTime.new(Date.today.year, Date.today.month, sender_pay_day)
        else
          return DateTime.new(Date.today.year, Date.today.month, Date.today.end_of_month.day)
        end
      else #me muevo al proximo mes
        if Date.today.next_month.end_of_month.day >= sender_pay_day #si el dia de pago esta correcto y no pasado
          return DateTime.new(Date.today.year, Date.today.next_month.month, sender_pay_day)
        else
          return DateTime.new(Date.today.year, Date.today.next_month.month, Date.today.next_month.end_of_month.day)
        end
      end
    else
      return default
    end
  end

end
