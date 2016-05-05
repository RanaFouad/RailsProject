Rails.application.routes.draw do
  resources :group_members
  get 'groups_member/index'

  resources :friendships
    resources :groups
     resources :groups_member
  get 'welcome/index'
  resources :order_details

  devise_for :users , :controllers => {registrations: 'users', :omniauth_callbacks => "callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
    post '/orders/batota/' => 'orders#batota'
    get '/orders/details/:id' => 'orders#details'
    get '/orders/join_details/:id' => 'orders#join_details'
    delete '/orders/delete_invitation/:id' => 'orders#delete_invitation'
    get '/orders/updateStatus/' => 'orders#updateStatus'
    # get '/orders/batota/' => 'orders#batota'
    put '/invitations/join/:id' => 'invitations#join', as: 'join'
 
    resources :orders do
    resources :order_details
    end  



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
