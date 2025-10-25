require "#{Rails.root}/lib/config_loader"

module Site
  Config = ConfigLoader.load_config("configuration")
end
