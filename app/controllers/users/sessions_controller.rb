module Users
  class SessionsController < Devise::SessionsController
    layout "administrate/application"
  end
end
