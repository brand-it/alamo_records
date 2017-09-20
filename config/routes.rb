# frozen_string_literal: true

Rails.application.routes.draw do

  resources :artists do
    resources :artist_charts, only: :index
  end

  resources :records
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'records#index'
end
