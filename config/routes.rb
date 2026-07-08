Rails.application.routes.draw do
  root "ana#sayfa"
  post "/", to: "ana#sayfa"
end