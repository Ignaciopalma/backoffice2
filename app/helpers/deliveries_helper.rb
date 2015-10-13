module DeliveriesHelper
  def get_estado delivery
    if delivery.pay_state_id != 2 && delivery.confirmed == 0
      return delivery.state.name
    elsif delivery.confirmed == 1 &&  delivery.pay_state_id != 2
      return "Confirmado, no pagado"
    else
      return "Confirmado, pagado"
    end
  end

  def get_estado_sender delivery
    if delivery.pay_state_id != 2 && delivery.confirmed == 0
      return delivery.state.name
    elsif delivery.confirmed == 1
      return "Confirmado"
    end
  end
end
