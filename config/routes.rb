Rails.application.routes.draw do
  scope module: :public do
    get 'items/index'
    get 'items/show'
  end
  root to: 'public/homes#top'
  get '/adout' => 'public/homes#about'
  
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }
   devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions:      'admin/sessions'
  }
end
