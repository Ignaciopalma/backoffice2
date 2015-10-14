class Delivery < ActiveRecord::Base

  has_many :delivery_photos, :dependent => :destroy
  belongs_to :state
  belongs_to :pay_state
  belongs_to :sender_pay_state
  belongs_to :sender
  belongs_to :user
  accepts_nested_attributes_for :delivery_photos

  validates :address_start, :address_finish , :comuna_start, :comuna_finish, :eta, :km, :destinatary_name, :destinatary_email, :ancho, :largo, :alto, :peso_neto, :sender_id,  :lat_start, :long_start, :lat_finish, :long_finish, presence: true

  validate :comunas_val
  validate :department_presence
  before_create :set_comission

  attr_accessor :pay_days
  attr_accessor :pay_date_day
  attr_accessor :pay_date_month
  attr_accessor :pay_date_year

  def department_presence
    if self.location_type == 'dept' and self.department_number.blank?
      errors.add(:department_number, "es obligatorio")
    end
  end

  def comunas_val
    count_first = 0
    count_second = 0
    AvailableArea.all.each do |ix|
      if ix.name == comuna_start
        count_first = 1
      end

      if ix.name == comuna_finish
        count_second = 1
      end
    end

    if count_first == 0
      errors.add(:comuna_start, "Comuna no disponible")
    end

    if count_second == 0
      errors.add(:comuna_finish, "Comuna no disponible")
    end
  end

  def set_comission
    if errors.blank? and self.try == 1
      peso_volumetrico = ancho*largo*alto/5000
      peso_final = (peso_neto > peso_volumetrico)? peso_neto : peso_volumetrico

      if self.both_ways
        self.cost = (BasePricing.first.value+(KgPricing.first.value*peso_final)+(KmPricing.first.value*self.km).ceil)*2
      else
        self.cost = BasePricing.first.value+(KgPricing.first.value*peso_final)+(KmPricing.first.value*self.km).ceil
      end

      #if self.both_ways
      #  self.cost = (BasePricing.first.value+(KgPricing.first.value*(peso_final**1.5))+(KmPricing.first.value*(self.km**1.5)).ceil)/1.19 #*2
      #else
      #  self.cost = (BasePricing.first.value+(KgPricing.first.value*(peso_final**1.5))+(KmPricing.first.value*(self.km**1.5)).ceil)/1.19
      #end


      self.comission = ((self.cost.to_f/1.19).floor * Pricing.first.percentage.to_f/100).floor
      self.vx_comission = (self.cost.to_f/1.19).round - self.comission
      self.iva = (self.cost/1.19 * 0.19).round

      #self.comission = ((self.cost.to_f).floor * Pricing.first.percentage.to_f/100).floor
      #self.vx_comission = (self.cost.to_f).floor - self.comission
      #self.iva = 1# (self.cost*0.19).round
    end
  end

  def fix_comission
    # self.comission = ((self.cost.to_f/1.19).floor * Pricing.first.percentage.to_f/100).floor
    # self.comission = ((self.cost.to_f).floor * Pricing.first.percentage.to_f/100).floor

    self.comission = ((self.cost.to_f/1.19).floor * Pricing.first.percentage.to_f/100).floor
    self.vx_comission = (self.cost.to_f/1.19).round - self.comission
    self.iva = (self.cost/1.19 * 0.19).round
  end
  #precio base, base peso, base km
  #% 90 - 10

end
