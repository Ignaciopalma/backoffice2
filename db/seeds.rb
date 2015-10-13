# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



user = User.create(
    {
        email: 'cyclist@vx.cl',
        password: '123123123',
        password_confirmation: '123123123',
        first_name: 'cyclist',
        last_name: 'cyclist',
        rut: '11111111-1',
        phone: '123123123',
        address: "dirección 2131",
        occupation_id: 1,
        bank_id: 1,
        account_type_id: 1,
        account_number: "12312321",
        active: 1
    })
user.set_cyclist_role


#user = User.create({email: 'admin@vx.cl', password: '123123123', first_name: 'admin', last_name: 'admin', rut: '11111111-1', phone: '123123123'})
#user.set_admin_role


#user = User.create({email: 'sender@vx.cl', password: '123123123', first_name: 'sender', last_name: 'sender', rut: '11111111-1', phone: '123123123'})
#user.set_sender_role

Sender.create(
    {email: 'sender@vx.cl',
     password: 'Veloexpress',
     password_confirmation: 'Veloexpress',
     business_name: 'Sender VeloExpress',
     rut: '76423948-2',
     giro: 'Servicio de transporte',
     address: 'Providencia 235',
     contact_name: 'Maximiliano López',
     contact_email: 'maxi.lopez.ramirez@gmail.com',
     phone_number: '84328492',
     razon_social: 'Transporte Veloexpress',
     area_id: 1,
     city_id: 1
    })

Admin.create({email: 'admin@vx.cl', password: 'Veloexpress', password_confirmation: 'Veloexpress'})

# 7 ACTIVOS
Delivery.create({
                    :sender_id => 1,
                    :eta => 20,
                    :km => 10,
                    :state_id => 1,
                    :pay_state_id => 1,
                    :comuna_start => "Providencia",
                    :comuna_finish => "Providencia",
                    :lat_start => -33.4205059,
                    :long_start => -70.607631,
                    :lat_finish => -33.4447412,
                    :long_finish => -70.6329551,
                    :address_start => "Providencia 2323",
                    :address_finish => "Vicuña Mackenna 248",
                    :comission => 1200,
                    :destinatary_name => "Jaime Perez",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now+(3*60*60*24)
                })

Delivery.create({
                    :sender_id => 1,
                    :eta => 50,
                    :km => 30,
                    :state_id => 1,
                    :pay_state_id => 1,
                    :comuna_start => "Providencia",
                    :comuna_finish => "La Florida",
                    :lat_start => -33.431777,
                    :long_start => -70.6076612,
                    :lat_finish => -33.5540597,
                    :long_finish => -70.5757157,
                    :address_start => "Ladislao Errázuriz 2149",
                    :address_finish => "La Florida Dos 3450",
                    :comission => 2000,
                    :destinatary_name => "Carmen Vial",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now+(13*60*60*24)
                })

Delivery.create({
                    :sender_id => 1,
                    :eta => 80,
                    :km => 50,
                    :state_id => 1,
                    :pay_state_id => 1,
                    :comuna_start => "Vitacura",
                    :comuna_finish => "Las Condes",
                    :lat_start => -33.3957881,
                    :long_start => -70.5833114,
                    :lat_finish => -33.4565987,
                    :long_finish => -70.5561527,
                    :address_start => "Las Hualtatas 5630",
                    :address_finish => "Los Militares 526",
                    :comission => 800,
                    :destinatary_name => "Vicente Zamora",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now+(23*60*60*24)
                })

Delivery.create({
                    :sender_id => 1,
                    :eta => 20,
                    :km => 30,
                    :state_id => 1,
                    :pay_state_id => 1,
                    :comuna_start => "Lo Prado",
                    :comuna_finish => "Providencia",
                    :lat_start => -33.4429285,
                    :long_start => -70.7134328,
                    :lat_finish => -33.4474702,
                    :long_finish => -70.6005075,
                    :address_start => "San Pablo 5690",
                    :address_finish => "Diego de Almagro 1866",
                    :comission => 2100,
                    :destinatary_name => "Consuelo Aro",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now+(30*60*60*24)
                })

Delivery.create({
                    :sender_id => 1,
                    :eta => 15,
                    :km => 10,
                    :state_id => 1,
                    :pay_state_id => 1,
                    :comuna_start => "Santiago",
                    :comuna_finish => "Las Condes",
                    :lat_start => -33.4590954,
                    :long_start => -70.6464035,
                    :lat_finish => -33.4158085,
                    :long_finish => -70.5917589,
                    :address_start => "Manuel Antonio Matta 922",
                    :address_finish => "El Golf 30",
                    :comission => "900",
                    :destinatary_name => "Sebastian Campos",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now+(60*60*60*24)
                })

Delivery.create({
                    :sender_id => 1,
                    :eta => 24,
                    :km => 10,
                    :state_id => 1,
                    :pay_state_id => 1,
                    :comuna_start => "Providencia",
                    :comuna_finish => "Providencia",
                    :lat_start => -33.4274724,
                    :long_start => -70.6171914,
                    :lat_finish => -33.4242933,
                    :long_finish => -70.6229197,
                    :address_start => "Providencia 1540",
                    :address_finish => "Santa María 1540",
                    :comission => 750,
                    :destinatary_name => "Paulina Guzmán",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now+(15*60*60*24)
                })

Delivery.create({
                    :sender_id => 1,
                    :eta =>32,
                    :km => 25,
                    :state_id => 1,
                    :pay_state_id => 1,
                    :comuna_start => "Quinta Normal",
                    :comuna_finish => "Providencia",
                    :lat_start => -33.4446018,
                    :long_start => -70.707324,
                    :lat_finish => -33.4242933,
                    :long_finish => -70.6229197,
                    :address_start => "Las Rejas Norte 726",
                    :address_finish => "Santa María 1540",
                    :comission => 1300,
                    :destinatary_name => "Tatiana Rodríguez",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now+(28*60*60*24)
                })


#END 7 ACTIVOS

# 3 HISTORIAL USER 1
Delivery.create({
                    :sender_id => 1,
                    :user_id => 1,
                    :eta => 120,
                    :km => 20,
                    :state_id => 4,
                    :pay_state_id => 1,
                    :comuna_start => "Santiago",
                    :comuna_finish => "Santiago",
                    :lat_start => -33.4384353,
                    :long_start => -70.6568096,
                    :lat_finish => -33.4384966,
                    :long_finish => -70.6510878,
                    :address_start => "Hermanos Amunátegui 456",
                    :address_finish => "Ahumada 659",
                    :comission => 1100,
                    :destinatary_name => "Carlos Guerra",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now-(3*60*60*24)
                })

Delivery.create({
                    :sender_id => 1,
                    :user_id => 1,
                    :eta => 50,
                    :km => 46,
                    :state_id => 2,
                    :pay_state_id => 1,
                    :comuna_start => "Recoleta",
                    :comuna_finish => "Providencia",
                    :lat_start => -33.43315,
                    :long_start => -70.6438107,
                    :lat_finish => -33.4242117,
                    :long_finish => -70.6055095,
                    :address_start => "Bellavista 291",
                    :address_finish => "Los Leones 458",
                    :comission => 800,
                    :destinatary_name => "Varinia Becerra",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now-(10*60*60*24)
                })

Delivery.create({
                    :sender_id => 1,
                    :user_id => 1,
                    :eta => 20,
                    :km => 23,
                    :state_id => 4,
                    :pay_state_id => 2,
                    :comuna_start => "Estación Central",
                    :comuna_finish => "San Joaquín",
                    :lat_start => -33.4623982,
                    :long_start => -70.7051068,
                    :lat_finish => -33.50707,
                    :long_finish => -70.6374851,
                    :address_start => "Las Rejas sur 726",
                    :address_finish => "Departamental 451",
                    :comission => 500,
                    :destinatary_name => "Eduardo Herrera",
                    :destinatary_email => "test@test.cl",
                    :ancho => 23,
                    :largo => 1.3,
                    :alto => 3.2,
                    :peso_neto => 10,
                    :pay_date => Time.now+(3*60*60*24)
                })
