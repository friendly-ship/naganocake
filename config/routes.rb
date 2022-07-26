Rails.application.routes.draw do

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:show, :index, :new, :create, :edit, :update]
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/complete'
    get 'orders/finish'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    resources :genres, only: [:show]
    get 'addresses/index'
    get 'addresses/edit'
    get 'addresses/create'
    get 'addresses/update'
    get 'addresses/destroy'
  end
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions:      'admin/sessions'
}
 devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  scope module: 'public' do
    resources :items, only: [:show, :index]
  end

end
