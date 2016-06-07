class Admin::UsersController < ActionController::Base
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :activate, :deactivate, :profile]


  layout 'admin'

  def index
    @users = User.all.order(:active).reverse_order
  end

  def show
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
    @total_comission = 0
    @deliveries.each do |delivery|
	@total_comission += delivery.comission
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @user.set_cyclist_role
        format.html { redirect_to admin_users_path, notice: 'El usuario ha sido creado exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user][:password] = @user.password
      params[:user][:password_confirmation] = @user.password
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user), notice: 'El usuario ha sido modificado exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def activate
    @user.active = 1
    respond_to do |format|
      if @user.save
        AppMailer.activated_acc(@user).deliver_later
        format.html { redirect_to admin_users_path, notice: 'El usuario ha sido activado exitosamente.' }
      else
        format.html { redirect_to admin_users_path, notice: 'Ha ocurrido un error'  }
      end
    end
  end

  def deactivate
    @user.active = 0
    respond_to do |format|
      if @user.save
        AppMailer.deactivated_acc(@user).deliver_later
        format.html { redirect_to admin_users_path, notice: 'El usuario ha sido desactivado exitosamente.' }
      else
        format.html { redirect_to admin_users_path, notice: 'Ha ocurrido un error'  }
      end
    end
  end

  def profile
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :occupation_id, :occupation_detail, :first_name, :last_name, :bank_id, :account_type_id, :account_number, :rut, :address, :phone)
  end
end
