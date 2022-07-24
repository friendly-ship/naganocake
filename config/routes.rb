Rails.application.routes.draw do
 root 'public/homes#top'
    devise_for :members, controllers: {
    sessions:      'members/sessions',
    passwords:     'members/passwords',
    registrations: 'members/registrations'
    }

    devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
    }

  namespace :admin do
    get '/admins' => 'admins#top'
    resources :items
    resources :genres
    resources :members
    resources :orders,only:[:index,:show,:update]
    resources :order_items, only:[:update]
  end

  namespace :public do
    get '/about' => 'homes#about'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :items, only:[:index,:show,:new] do
        get :search, on: :collection # ジャンル検索機能用
    end
    resources :cart_items
    post '/orders/session' => 'orders#session_create'
    get '/orders/confirm' => 'orders#confirm'
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/thanks' => 'orders#thanks'
    patch '/members/withdrawal' => 'members#destroy'
    get '/members/withdrawal' => 'members#withdrawal'
    resources :orders, only:[:new,:create,:index,:show]
    resource :members, only:[:show ,:edit,:update]
    resources :addresses, only:[:index, :edit, :destroy, :create, :update]
  end
end