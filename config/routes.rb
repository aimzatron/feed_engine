FeedEngine::Application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match '', to: 'users#show', constraints: {subdomain: /.+/}
  root :to => "home#show"
end
