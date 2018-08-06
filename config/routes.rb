Rails.application.routes.draw do
  root to: 'home_page#homepage'

  devise_for :users
  
  get 'leave_application/action_history'
  
  get 'leave_application/show_action/:id' , :to => 'leave_application#show_action'

  get 'leave_application/worklist'

  resources :leave_application, :except => [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
