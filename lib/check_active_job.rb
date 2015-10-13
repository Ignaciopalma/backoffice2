class CheckActiveJob < Struct.new(:user_id, :delivery_id)
  def perform
    delivery = Delivery.find(delivery_id)
    if delivery.user_id == user_id and delivery.state_id == 2
      delivery.user_id = nil
      delivery.state_id = 1
      delivery.save
    end
  end
end