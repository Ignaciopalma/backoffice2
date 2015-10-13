class Admin::AvailableAreasController <  ActionController::Base
  before_action :authenticate_admin!
  before_action :set_available_area, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  def index
    @available_areas = AvailableArea.all
  end

  def show
  end

  def new
    @available_area = AvailableArea.new
  end

  def edit
  end

  def create
    @available_area = AvailableArea.new(available_area_params)

    respond_to do |format|
      if @available_area.save
        format.html { redirect_to admin_available_areas_url, notice: 'Available area was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @available_area.update(available_area_params)
        format.html { redirect_to admin_available_areas_url, notice: 'Available area was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @available_area.destroy
    respond_to do |format|
      format.html { redirect_to admin_available_areas_url, notice: 'Available area was successfully destroyed.' }
    end
  end

  private
    def set_available_area
      @available_area = AvailableArea.find(params[:id])
    end

    def available_area_params
      params.require(:available_area).permit(:id, :name)
    end
end
