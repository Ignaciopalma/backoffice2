class Sender::DeliveriesController < ApplicationController
  before_action :authenticate_sender!, except: [:get_user]
  before_action :set_delivery, only: [:show, :edit, :update, :destroy, :confirm_delivery]

  layout 'admin'

  def index

    @month = ""
    @year = ""
    if params[:month].nil?
      @month = Time.now.month
    elsif params[:month].blank?
      @month = ""
    else
      @month = params[:month]
    end

    if params[:year].nil?
      @year = Time.now.year
    elsif params[:year].blank?
      @year = ""
    else
      @year = params[:year]
    end

    if params[:state].present?
      @deliveries_pre = Delivery.where(:sender_id => current_sender.id, state_id: params[:state]).order(:id).reverse_order
    elsif params[:confirmed].present?
      @deliveries_pre = Delivery.where(:sender_id => current_sender.id, confirmed: params[:confirmed]).order(:id).reverse_order
    elsif params[:sender_pay].present?
      @deliveries_pre = Delivery.where(:sender_id => current_sender.id, sender_pay_state_id: params[:sender_pay], confirmed: 1).order(:id).reverse_order
    else
      @deliveries_pre = Delivery.where(:sender_id => current_sender.id).order(:id).reverse_order
    end


    @total = 0
    @deliveries = []

    @deliveries_pre.each do |delivery|
      if @month == "" and @year == ""
        @deliveries << delivery
      elsif @month == "" and @year.present?
        @deliveries << delivery if  delivery.created_at.year.to_i == @year.to_i
      elsif @month.present? and @year == ""
        @deliveries << delivery if delivery.created_at.month.to_i == @month.to_i
      elsif @month.present? and @year.present?
        @deliveries << delivery if (delivery.created_at.month.to_i == @month.to_i and delivery.created_at.year.to_i == @year.to_i)
      end
    end

    @distancia = 0.0
    @deliveries.each do |delivery|
      @total = @total + delivery.cost
      @distancia += delivery.km.to_f
    end

    if @deliveries.length == 0
      @distancia = 0
    else
      @distancia /= @deliveries.length
    end
  end

  def show
    qr = RQRCode::QRCode.new( @delivery.id.to_s, :size => 4, :level => :h )
    @QR = qr

  end

  def new
    @delivery = Delivery.new
    @delivery.pay_date = calculate_pay_date(current_sender.pay_day)
  end

  def edit
    @delivery.delivery_photos.build
  end

  def create
    if params[:pay_date_submit].present?
      params[:delivery][:pay_date] = params[:pay_date_submit]
    end

    @delivery = Delivery.new(delivery_params)
    @delivery.sender_id = current_sender.id
    @delivery.state_id = 1
    @delivery.pay_state_id = 1
    @delivery.sender_pay_state_id = 1
    @delivery.confirmed = 0
    @delivery.user_id = nil
    respond_to do |format|
      if @delivery.save
        format.html { redirect_to sender_delivery_path(@delivery), notice: 'El envío ha sido creado exitosamente' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if params[:pay_date_submit].present?
      params[:delivery][:pay_date] = params[:pay_date_submit]
    end
    respond_to do |format|
      if @delivery.update(delivery_params)
        format.html { redirect_to sender_delivery_path(@delivery), notice: 'El envío ha sido modificado exitosamente' }
      else
        format.html { render :edit }
      end
    end
  end

  def confirm_delivery
    @delivery.confirmed = 1
    respond_to do |format|
      if @delivery.save
        format.html { redirect_to sender_deliveries_path(:confirmed => 1), notice: 'El envío se ha confirmado.' }
      end
      format.html { redirect_to sender_deliveries_path(:confirmed => 1), notice: 'Ha ocurrido un error.' }
    end

  end

  def user_delivery
    @user = User.find_by_id(params[:id])
    @deliveries_pre = @user.deliveries.where('state_id > 1').order(:created_at)
    @total_envios = @deliveries_pre.length

    @month = ""
    @year = ""
    if params[:month].nil?
      @month = Time.now.month
    elsif params[:month].blank?
      @month = ""
    else
      @month = params[:month]
    end

    if params[:year].nil?
      @year = Time.now.year
    elsif params[:year].blank?
      @year = ""
    else
      @year = params[:year]
    end

    @deliveries = []

    @deliveries_pre.each do |delivery|
      if @month == "" and @year == ""
        @deliveries << delivery
      elsif @month == "" and @year.present?
        @deliveries << delivery if  delivery.created_at.year.to_i == @year.to_i
      elsif @month.present? and @year == ""
        @deliveries << delivery if delivery.created_at.month.to_i == @month.to_i
      elsif @month.present? and @year.present?
        @deliveries << delivery if (delivery.created_at.month.to_i == @month.to_i and delivery.created_at.year.to_i == @year.to_i)
      end
    end

  end

  def grace
    @delivery_clone = Delivery.find(params[:id])

    if @delivery_clone.blank? or @delivery_clone.sender_id != current_sender.id or @delivery_clone.try != 1 or @delivery_clone.state_id != 5
      redirect_to sender_deliveries_path, notice: 'No tienes permisos para clonar el envío seleccionado'
      return false
    end
    @delivery_clone.try += 1

    if @delivery_clone.save
      @delivery = @delivery_clone.dup
      @delivery.state_id = 1
      @delivery.pay_state_id = 1
      @delivery.sender_pay_state_id = 1
      @delivery.confirmed = 0
      @delivery.user_id = nil
      @delivery.pay_date = calculate_pay_date(current_sender.pay_day)
      @delivery.cost = 0
      @delivery.iva = 0
      @delivery.vx_comission = 0

      if @delivery.save!
        redirect_to sender_deliveries_path, notice: 'Se ha creado exitosamente el envio de gracia'
        return false
      else
        redirect_to sender_deliveries_path, notice: 'Ha ocurrido un error, intente nuevamente'
        return false
      end
    else
      redirect_to sender_deliveries_path, notice: 'Ha ocurrido un error, intente nuevamente'
      return false
    end
  end

  def perfil
    @sender = Sender.find(current_sender.id)
  end

  def change_pass
    @sender = Sender.find(current_sender.id)

    if params[:sender][:password].blank? && params[:sender][:password_confirmation].blank?
      params[:sender][:password] = @sender.password
      params[:sender][:password_confirmation] = @sender.password
    end
    respond_to do |format|
      if @sender.update(sender_params)
        format.html { redirect_to sender_deliveries_url, notice: 'La empresa ha sido editado exitosamente.' }
      else
        format.html { redirect_to sender_deliveries_url, notice: 'Ha ocurrido un error'  }
      end
    end
  end

  def get_user
    @user = User.find(params[:user_id])

    respond_to do |format|
      format.json { render :json => {:lon => @user.lon, :lat => @user.lat},  status: :ok}
    end

  end

  private
  def set_delivery
    @delivery = Delivery.find(params[:id])
    if @delivery.present? and @delivery.sender_id != current_sender.id
      respond_to do |format|
        format.html { redirect_to sender_deliveries_url, notice: 'No tienes permisos para ver el envío.' }
      end
      return false
    end

  end

  def delivery_params
    params.require(:delivery).permit(:id, :eta, :km, :state_id, :pay_state_id, :pay_date, :comuna_start, :comuna_finish, :lat_start, :long_start, :lat_finish, :long_finish, :photo_id, :address_start, :address_finish, :destinatary_name, :destinatary_email, :ancho, :largo, :alto, :peso_neto, :more_info, :department_number, :both_ways,:location_type, :delivery_photos_attributes => [:photo, :status])
  end

  def sender_params
    params.require(:sender).permit(:id, :email, :password, :pay_day, :password_confirmation,:contact_name,:contact_email,:phone_number,:business_name,:razon_social,:rut,:giro,:address,:area_id,:city_id)
  end
end
