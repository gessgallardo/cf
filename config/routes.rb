# frozen_string_literal: true

Rails.application.routes.draw do
  root 'application#index'

  namespace :api, defaults: { format: :json } do
    namespace :school do
      namespace :v1 do
        resources :students, only: :show do
          resources :mentors, only: %i[index show] do
            get 'availibility'
          end
        end
      end
    end
  end
end
