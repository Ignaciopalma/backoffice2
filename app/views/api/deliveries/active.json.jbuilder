if @deliveries.present?
  json.array!(@deliveries) do |delivery|
    json.extract! delivery, :id,
                  :sender_id,
                  :user_id,
                  :eta,
                  :km,
                  :state_id,
                  :pay_state_id,
                  :comuna_start,
                  :comuna_finish,
                  :lat_start,
                  :long_start,
                  :lat_finish,
                  :long_finish,
                  :photo_id,
                  :address_start,
                  :address_finish,
                  :comission,
                  :destinatary_name,
                  :pay_date,
                  :pay_days,
                  :pay_date_day,
                  :pay_date_month,
                  :pay_date_year,
                  :created_at,
                  :updated_at,
                  :peso_neto,
                  :ancho,
                  :largo,
                  :alto,
                  :department_number,
                  :more_info,
                  :both_ways,
                  :location_type
    json.url api_delivery_url(delivery, format: :json)
  end
else
  {}
end