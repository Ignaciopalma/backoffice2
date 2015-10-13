class Admin::PricingsController < ActionController::Base
  before_action :authenticate_admin!

  layout 'admin'

  def index
    @base = BasePricing.first
    @km = KmPricing.first
    @kg = KgPricing.first
    @cyclist_p = Pricing.first
  end

  def update
    @base = BasePricing.first
    @km = KmPricing.first
    @kg = KgPricing.first
    @cyclist_p = Pricing.first

    if params[:base].present?
      @base.value = params[:base]
    end

    if params[:km].present?
      @km.value = params[:km]
    end

    if params[:kg].present?
      @kg.value = params[:kg]
    end

    if params[:cyclist_p].present?
      @cyclist_p.percentage = params[:cyclist_p]
    end

    respond_to do |format|
      if @base.save and @km.save and @kg.save and @cyclist_p.save
        format.html { redirect_to '/admin/pricings', notice: 'Los cambios han sido guardado exitosamente' }
      else
        format.html { redirect_to '/admin/pricings', notice: 'Ha ocurrido un error' }
      end
    end

  end

  private

end
