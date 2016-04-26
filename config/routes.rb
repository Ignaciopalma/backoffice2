Rails.application.routes.draw do

  match '*any' => 'application#options', :via => [:options]

  namespace :api, path: 'api', defaults: {format: 'json'} do
    resources :deliveries
    post   'deliveries/availables' => 'deliveries#availables'
    post   'deliveries/start_delivery' => 'deliveries#start_delivery'
    post   'deliveries/history' => 'deliveries#history'
    post   'deliveries/active' => 'deliveries#active'
    post   'deliveries/get_qr' => 'deliveries#get_qr'
    post   'deliveries/get_accepted_image' => 'deliveries#get_accepted_image'
    post   'deliveries/get_rejected_image' => 'deliveries#get_rejected_image'
    post   'deliveries/cancel_delivery' => 'deliveries#cancel_delivery'
    post   'deliveries/end_rejected_delivery' => 'deliveries#end_rejected_delivery'
    get    'deliveries/confirm_delivery/:delivery_sender_id/:delivery_id/:delivery_user_id/key' => 'deliveries#confirm_delivery'
    post   'deliveries/delivery' => 'deliveries#delivery'
    post   'deliveries/upload_photo' => 'deliveries#upload_photo'
    post   'deliveries/finish_delivery' => 'deliveries#finish_delivery'


    #rutas del login
    post   'login'    => 'session#create'
    delete 'logout'   => 'session#destroy'
    post   'islogged' => 'session#isLogged'
    post   'banks'    => 'session#get_banks'
    post   'account_types'    => 'session#get_account_types'
    post   'occupations'    => 'session#get_occupations'
    post   'get_confirmed_deliveries' => 'session#get_confirmed_deliveries'
    post   'update_user' => 'session#update_user'
    post   'register_user' => 'session#register_user'
    post   'invite_friend' => 'session#invite_friend'
    post   'create_problem' => 'session#create_problem'
    post   'update_position' => 'session#update_position'
    post   'recover_password' => 'session#recover_password'
    get    'recover/:token' => "session#recover", format: 'html'
    post    'recover/:token' => "session#do_recover", format: 'html'

  end

  devise_for :senders, :path => "sender", controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  devise_for :admins, :path => "admin"

  namespace :sender, path: 'sender' do
    resources :deliveries
    get  'deliveries/confirm_delivery/:id' => 'deliveries#confirm_delivery'
    get  'deliveries/user_delivery/:id' => 'deliveries#user_delivery'
    get  'perfil' => 'deliveries#perfil'
    get  'deliveries/grace/:id' => 'deliveries#grace'
    patch  'change_pass' => 'deliveries#change_pass'
    get  'get_user/:user_id' => 'deliveries#get_user'
  end

  namespace :admin, path: 'admin' do
    resources :deliveries
    resources :senders
    resources :users
    resources :available_areas
    resources :problems
    resources :pricings

    get  'deliveries/confirm_delivery/:id' => 'deliveries#confirm_delivery'
    get  'deliveries/pay_delivery/:id' => 'deliveries#pay_delivery'
    get  'deliveries/sender_pay_delivery/:id' => 'deliveries#sender_pay_delivery'

    get  'users/activate/:id' => 'users#activate'
    get  'users/deactivate/:id' => 'users#deactivate'

    get  'deliveries/grace/:id' => 'deliveries#grace'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'sender/deliveries#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
