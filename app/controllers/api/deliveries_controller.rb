class Api::DeliveriesController < Api::ApiController
  before_action :logged_filter, except: [:confirm_delivery, :upload_photo]
  before_action :set_delivery, only: [:show, :edit, :update, :destroy, :delivery]

  def index
    @deliveries = Delivery.all
  end

  def show
    @delivery.pay_date_day = @delivery.pay_date.day
    @delivery.pay_date_month = @delivery.pay_date.month
    @delivery.pay_date_year = @delivery.pay_date.year
  end

  def new
    @delivery = Delivery.new
  end

  def edit
  end

  def create
    @delivery = Delivery.new(delivery_params)

    respond_to do |format|
      if @delivery.save
        format.json { render :show, status: :created, location: @delivery }
      else
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @delivery.update(delivery_params)
        format.json { render :show, status: :ok, location: @delivery }
      else
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  def delivery
    @delivery.pay_date_day = @delivery.pay_date.day
    @delivery.pay_date_month = @delivery.pay_date.month
    @delivery.pay_date_year = @delivery.pay_date.year
  end

  def destroy
    @delivery.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def availables
    @deliveries = Delivery.where(:user_id => nil)
    @deliveries.each do |d|
      if d.pay_date.present?
        d.pay_days = ((d.pay_date - Time.now)/86400).ceil
        if d.pay_days < 0
          d.pay_days = 0
        end
        d.pay_date_day = d.pay_date.day
        d.pay_date_month = d.pay_date.month
        d.pay_date_year = d.pay_date.year
      end
    end
  end

  def history
    @deliveries = Delivery.where("user_id = ? AND state_id >= ?", @user.id, 4)
    @deliveries.each do |d|
      if d.pay_date.present?
        d.pay_days = ((d.pay_date - Time.now)/86400).ceil
        if d.pay_days < 0
          d.pay_days = 0
        end
        d.pay_date_day = d.pay_date.day
        d.pay_date_month = d.pay_date.month
        d.pay_date_year = d.pay_date.year
      end
    end
  end

  def active
    @deliveries = Delivery.where("user_id = ? AND state_id < ?", @user.id, 4)
    @deliveries.each do |d|
      if d.pay_date.present?
        d.pay_days = ((d.pay_date - Time.now)/86400).ceil
        if d.pay_days < 0
          d.pay_days = 0
        end
        d.pay_date_day = d.pay_date.day
        d.pay_date_month = d.pay_date.month
        d.pay_date_year = d.pay_date.year
      end
    end
  end

  def start_delivery
    @delivery = Delivery.where(:id => params[:delivery_id]).first
    respond_to do |format|
      if @delivery.user_id == nil
        @delivery.user_id = @user.id
        @delivery.state_id = 2
        if @delivery.save
          #::Delayed::Job.enqueue(::CheckActiveJob.new(@delivery.user_id, @delivery.id), {:priority => 100, :run_at => 15.minutes.from_now})
          #format.json { render :json => {:msg => "Has tomado el pedido exitosamente, recuerda que tienes 15 minutos para marcar el pedido o se liberará para que otra persona pueda tomarlo"}, :status => :ok}
          format.json { render :json => {:msg => "Has tomado el pedido exitosamente."}, :status => :ok}
        else
          format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"}, :status => :unprocessable_entity}
        end
      else
        format.json { render :json => {:msg => "El pedido ya fue tomado por otra persona"}, :status => :unprocessable_entity}
      end
    end
  end

  def get_qr
    @delivery = Delivery.where(:id => params[:qr_id][:text], :user_id => @user.id, :state_id => 2).first
    respond_to do |format|
      if @delivery.present?
        @delivery.state_id = 3

        if @delivery.save
          format.json { render :json => {:msg => "Ha ingresado el QR exitosamente"},  status: :ok}
        else
          format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :unprocessable_entity}
        end
      else
        @delivery_other_state = Delivery.where(:id => params[:qr_id][:text], :user_id => @user.id).first
        @delivery_other_user = Delivery.where(:id => params[:qr_id][:text]).first
        if @delivery_other_state.present?
          format.json { render :json => {:msg => "El QR ya fue ingresado al sistema"},  status: :unprocessable_entity}
        elsif @delivery_other_user.present?
          format.json { render :json => {:msg => "El pedido pertenece a otro usuario"},  status: :unprocessable_entity}
        end

      end
    end


  end

  def get_accepted_image
    @delivery = Delivery.where(:id => params[:delivery_id], :user_id => @user.id).first

    @delivery.state_id = 4 #termina el envio con codigo de exito
    respond_to do |format|
      if @delivery.save
        AppMailer.confirm(@delivery).deliver_later #envia un mail de confirmacion al receptor
        format.json { render :json => {:msg => "ok"},  status: :ok}
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :ok}
      end
    end
  end

  def upload_photo
    @photo = DeliveryPhoto.new
    @photo.photo = params[:photo]
    @photo.delivery_id = params[:delivery_id]
    @photo.status = params[:status]
    respond_to do |format|

      if @photo.blank? and @photo.delivery_id.blank? and @photo.status.blank?
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :unprocessable_entity}
        return
      end

      if @photo.save
        format.json { render :json => {:msg => "Se ha ingresado la imagen exitosamente"},  status: :ok}
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :unprocessable_entity}
      end
    end
  end

  def get_rejected_image
    @delivery = Delivery.where(:id => params[:delivery_id], :user_id => @user.id).first
    respond_to do |format|
      if @delivery.save
        format.json { render :json => {:msg => "ok"},  status: :ok}
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :unprocessable_entity}
      end
    end
  end

  def end_rejected_delivery
    @delivery = Delivery.where(:id => params[:delivery_id], :user_id => @user.id).first
    has_rejected = false
    @delivery.delivery_photos.each do |d|
      if d.status == 0
        has_rejected = true
      end
    end

    respond_to do |format|
      if has_rejected
        @delivery.state_id = 5
        if @delivery.save
          format.json { render :json => {:msg => "ok"},  status: :ok}
        else
          format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :ok}
        end
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :ok}
      end
    end
  end

  def finish_delivery

    @delivery = Delivery.where(:id => params[:delivery_id], :user_id => @user.id).first
    success = false

    if @delivery.blank? or @delivery.delivery_photos.first.blank?
      respond_to do |format|
        format.json { render :json => {:msg => "El pedido aún no tiene fotos asociadas"},  status: :unprocessable_entity}
      end
      return
    end

    if @delivery.delivery_photos.last.status == 1
      success = true
    elsif @delivery.delivery_photos.last.status == 0
      success = false
    end

    respond_to do |format|
      if success
        @delivery.state_id = 4
        if @delivery.save
          format.json { render :json => {:msg => "El envío ha sido finalizado y marcado como exitoso"},  status: :ok}
        else
          format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :unprocessable_entity}
        end
      else
        @delivery.state_id = 5
        if @delivery.save
          format.json { render :json => {:msg => "El envío ha sido finalizado y marcado como fallido"},  status: :ok}
        else
          format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :unprocessable_entity}
        end
      end
    end

  end

  def cancel_delivery
    delivery = @user.deliveries.where(:state_id => 2, :id => params[:delivery_id]).first
    delivery.state_id = 1
    delivery.user_id = nil
    respond_to do |format|
      if delivery.save
        format.json { render :json => {:msg => "Has cancelado el envío exitosamente"},  status: :ok}
      else
        format.json { render :json => {:msg => "Ocurrió un error, intente nuevamente"},  status: :unprocessable_entity}
      end

    end
  end

  def confirm_delivery
    @delivery = Delivery.where(:sender_id => params[:delivery_sender_id], :id => params[:delivery_id], :user_id => params[:delivery_user_id]).first
    @delivery.confirmed = 1
    if @delivery.save
      redirect_to 'http://veloexpress.cl'
    else
      redirect_to 'http://veloexpress.cl'
    end
  end

  private
  def set_delivery
    @delivery = Delivery.find(params[:id])
    if @delivery.user_id != @user.id and @delivery.user_id != nil
      respond_to do |format|
        format.json { render :json => {:msg => "Este envío pertenece a otro usuario"},  status: :unprocessable_entity}
      end
      return false
    end
  end

  def delivery_params
    params.require(:delivery).permit(:id, :sender_id, :user_id, :eta, :km, :state_id, :pay_days, :pay_date, :pay_state_id, :comuna_start, :comuna_finish, :lat_start, :long_start, :lat_finish, :long_finish, :photo_id, :address_start, :address_finish, :comission, :destinatary_name, :more_info, :department_number, :both_ways)
  end

  def logged_filter
    @user = User.find_by_api_key(params[:api_key])
    if @user.blank? || @user.active == 0
      respond_to do |format|
        format.json { render :json => {:msg => "No autorizado"},  status: :unauthorized}
      end
      return false
    end
  end

end
