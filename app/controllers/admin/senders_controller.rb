class Admin::SendersController < ActionController::Base
  before_action :authenticate_admin!
  before_action :set_sender, only: [:show, :edit, :update, :destroy]


  layout 'admin'

  def index
    @senders = Sender.all
  end

  def show
  end

  def new
    @sender = Sender.new
  end

  def edit
  end

  def create
    @sender = Sender.new(sender_params)

    respond_to do |format|
      if @sender.save
        format.html { redirect_to admin_sender_path(@sender), notice: 'La empresa ha sido creado exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if params[:sender][:password].blank? && params[:sender][:password_confirmation].blank?
      params[:sender][:password] = @sender.password
      params[:sender][:password_confirmation] = @sender.password
    end
    respond_to do |format|
      if @sender.update(sender_params)
        format.html { redirect_to admin_sender_path(@sender), notice: 'La empresa ha sido editado exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @sender.destroy
    respond_to do |format|
      format.html { redirect_to admin_senders_url, notice: 'La empresa ha sido eliminado exitosamente.' }
    end
  end

  private
  def set_sender
    @sender = Sender.find(params[:id])
  end

  def sender_params
    params.require(:sender).permit(:id, :email, :password, :password_confirmation,:contact_name,:contact_email,:phone_number,:business_name,:razon_social,:rut,:giro,:address,:area_id,:city_id, :pay_day)
  end

end
