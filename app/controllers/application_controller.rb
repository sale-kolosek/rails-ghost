class ApplicationController < ActionController::Base
  before_action :resolve_app
  before_action :load_scripts

  def resolve_app
    @app ||= (Site::Config.site.app_domain || request.host).gsub(".", "")
  end

  def ghost_client
    @ghost_client ||= Ghost::Client.new
  end

  def set_settings
    begin
      @settings = Rails.cache.fetch("ghost_settings_#{@app}", expires_in: 1.hour) do
        ghost_client.get_data(:settings)
      end
    rescue
      @settings = {}
    end
  end

	def route_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found
  end

  private

  def load_scripts
    @header_script = Script.find_by(key: 'header')&.value
    @footer_script = Script.find_by(key: 'footer')&.value
  end
end
