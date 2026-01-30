module Ghost
  class RequestPath

    attr_accessor :host_url, :api_key

    class InvalidPath < StandardError; end


    def initialize(host = nil)
      @host_url = build_host_url(host)
      @api_key = Site::Config.site.ghost_api_content_key
    end

    private

    def build_host_url(host)
      configured_host = Site::Config.site.ghost_api_host.presence
      return "#{configured_host}/ghost/api" if configured_host

      return "https://blog.#{host}/ghost/api" if host.present?

      nil
    end

    public

    def path(method, params)
      return nil unless host_url.present?

      send(method, params)
    rescue => e
      raise InvalidPath.new(e.message)
    end

    def pages(params)
      "#{host_url}/content/pages?key=#{api_key}&page=#{params[:page]}"
    end

    def page(params)
      "#{host_url}/content/pages/slug#{params[:slug]}?key=#{api_key}"
    end

    def post(params)
      path = params[:path]
      "#{host_url}/content/posts/slug/#{path.sub(/^\/blog\//, '')}?key=#{api_key}&include=authors,tags"
    end

    def posts(params)
      "#{host_url}/content/posts?key=#{api_key}&include=authors,tags&page=#{params[:page]}"
    end

    def settings(params)
      "#{host_url}/content/settings?key=#{api_key}"
    end
  end
end