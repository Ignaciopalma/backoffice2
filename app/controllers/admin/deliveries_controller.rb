class Admin::DeliveriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_delivery, only: [:show, :edit, :update, :destroy, :confirm_delivery, :pay_delivery, :sender_pay_delivery]

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
      @deliveries_pre = Delivery.where( state_id: params[:state]).order(:id).reverse_order
    elsif params[:confirmed].present?
      @deliveries_pre = Delivery.where( confirmed: params[:confirmed]).order(:id).reverse_order
    elsif params[:sender_pay].present?
      @deliveries_pre = Delivery.where( sender_pay_state_id: params[:sender_pay], confirmed: 1).order(:id).reverse_order
    elsif params[:pay].present?
      @deliveries_pre = Delivery.where( pay_state_id: params[:pay], confirmed: 1).order(:id).reverse_order
    elsif params[:pay].present? && params[:sender_pay].present?
      @deliveries_pre = Delivery.where( pay_state_id: 2, sender_pay_state_id: 2, confirmed: 1).order(:id).reverse_order
    elsif
      @deliveries_pre = Delivery.all.order(:id).reverse_order
    end
    @iva = @monto_vx = @monto_ciclistas = 0

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

    @deliveries.each do |delivery|
      @monto_vx = @monto_vx + delivery.vx_comission
      @monto_ciclistas = @monto_ciclistas + delivery.comission
      @iva = @iva + delivery.iva
    end


  end

  def show
    @QR = RQRCode::QRCode.new( @delivery.id.to_s, :size => 4, :level => :h )
  end

  def new
    @delivery = Delivery.new
  end

  def edit
    @delivery.delivery_photos.build
  end

  def create
    if params[:pay_date_submit].present?
      params[:delivery][:pay_date] = params[:pay_date_submit]
    end

    @delivery = Delivery.new(delivery_params)

    respond_to do |format|
      if @delivery.save
        format.html { redirect_to admin_deliveries_path, notice: 'El envío ha sido creado exitosamente' }
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
        format.html { redirect_to admin_deliveries_path, notice: 'El envío ha sido modificado exitosamente' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @delivery.destroy
    respond_to do |format|
      format.html { redirect_to admin_deliveries_url, notice: 'El envío ha sido eliminado exitosamente' }
    end
  end

  def pay_delivery
    @delivery.pay_state_id = 2
    respond_to do |format|
      if @delivery.save
        format.html {redirect_to admin_delivery_path(@delivery), notice: 'La empresa ha sido marcada como pagado.' }
      end
      format.html { redirect_to admin_delivery_path(@delivery), notice: 'Ha ocurrido un error.' }
    end
  end

  def sender_pay_delivery
    @delivery.sender_pay_state_id = 2
    respond_to do |format|
      if @delivery.save
        format.html {redirect_to admin_delivery_path(@delivery), notice: 'El ciclista ha sido marcado como pagado.' }
      end
      format.html { redirect_to admin_delivery_path(@delivery), notice: 'Ha ocurrido un error.' }
    end
  end

  def confirm_delivery
    @delivery.confirmed = 1
    respond_to do |format|
      if @delivery.save
        format.html { redirect_to admin_delivery_path(@delivery), notice: 'El envío se ha confirmado.' }
      end
      format.html { redirect_to admin_delivery_path(@delivery), notice: 'Ha ocurrido un error.' }
    end

  end


  private
  def set_delivery
    @delivery = Delivery.find(params[:id])
  end

  def delivery_params
    params.require(:delivery).permit(:id, :sender_id, :pay,:cyclist_id, :pay_date, :eta, :km, :state, :pay_state, :comuna_start, :comuna_finish, :lat_start, :long_start, :lat_finish, :long_finish, :photo_id, :address_start, :address_finish, :comission, :destinatary_name, :destinatary_email, :ancho, :largo, :alto, :peso_neto, :more_info, :department_number, :both_ways, :location_type, :delivery_photos_attributes => [:photo, :status])
  end
end
