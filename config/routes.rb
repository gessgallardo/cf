# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#index'

  namespace :api, defaults: { format: :json } do
    namespace :school do
      namespace :v1 do
        resources :students, only: :show do
          resources :mentors, only: :index do
            member do
              get 'availibility'
              post 'schedule'
            end
          end
        end
      end
    end
  end
end
