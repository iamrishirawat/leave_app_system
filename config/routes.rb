Rails.application.routes.draw do
  root to: 'home_page#homepage'

  devise_for :users
  
  get 'leave_system/action_history'
  
  get 'leave_system/show_action/:id' , :to => 'leave_system#show_action'

  get 'leave_system/worklist'

  resources :leave_system, :except => [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
