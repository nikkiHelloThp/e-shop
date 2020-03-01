# frozen_string_literal: true

Rails.application.routes.draw do

  root 'home#index'
  get 'orders', to: 'home#orders'

  resources :products, only: [:show] # ATTENTION CONFLIT AVEC SCOPE ADMIN !!!
  
  scope module: :admin do
    resources :dashboard, only: [:index]
    resources :products
  end

  scope '/checkout' do
  	post 'create', to: 'checkout#create', as: 'checkout_create'
  	get 'success', to: 'checkout#success', as: 'checkout_success'
  	get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  resource :cart, only: [:show]
  resources :order_products, only: %i[create update destroy]

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
