# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  resource :cart, only: [:show]
  resources :order_products, only: %i[create destroy]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
