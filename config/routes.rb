FeedEngine::Application.routes.draw do
  # match '', to: 'users#show', constraints: {subdomain: /.+/}
  resources :feed_items
  resources :tl_texts
  resources :tl_images
  resources :tl_links
  resources :soundcloud_auths do
    member do
      post :approve
    end
  end

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'connect/lastfm/callback', to: 'lastfm_auths#create'
  match 'connect/soundcloud/callback', to: 'soundcloud_auths#create'
  match 'signout', to: 'sessions#destroy', as: 'signout'
  match '', to: 'users#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  root :to => "home#show"

  mount Resque::Server => '/resque'
end
