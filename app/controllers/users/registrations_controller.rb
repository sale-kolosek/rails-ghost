module Users
  class RegistrationsController < Devise::RegistrationsController
    layout "administrate/application"
  end
end
