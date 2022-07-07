Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'book', to: 'tables_booking#book'
    end
  end
end
