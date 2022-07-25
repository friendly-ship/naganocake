Rails.application.routes.draw do
  namespace :public do
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/complete'
    get 'orders/finish'
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
    get 'addresses/create'
    get 'addresses/update'
    get 'addresses/destroy'
  end
 devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}
end
