class GhostClient
  attr_reader :host

  def initialize(host = nil)
    @host = host
    @domain_config = fetch_domain_config(host)
  end

  def get_pages(page = 1)
    return [] unless configured?

    begin
      resp = HTTParty.get(
        "#{host_url}/content/pages?key=#{api_key}&page=#{page}"
      )

      JSON.parse(resp.body)['pages']
    rescue => e
      Rails.logger.error e.message
      []
    end
  end

  def get_page(slug)
    return nil unless configured?

    begin
      resp = HTTParty.get(
        "#{host_url}/content/pages/slug#{slug}?key=#{api_key}"
      )

      JSON.parse(resp.body)['pages']&.first
    rescue => e
      Rails.logger.error e.message
      nil
    end
  end

  def get_post(path)
    return nil unless configured?

    begin
      resp = HTTParty.get(
        "#{host_url}/content/posts/slug/#{path.sub(/^\/blog\//, '')}?key=#{api_key}&include=authors,tags"
      )

      JSON.parse(resp.body)['posts'].first
    rescue => e
      Rails.logger.error e.message
      nil
    end
  end

  def get_posts(page)
    return nil unless configured?

    begin
      resp = HTTParty.get(
        "#{host_url}/content/posts?key=#{api_key}&include=authors,tags&page=#{page}"
      )

      JSON.parse(resp.body)['posts']
    rescue => e
      Rails.logger.error e.message
    end
  end

  def settings
    return nil unless configured?

    begin
      resp = HTTParty.get(
        "#{host_url}/content/settings?key=#{api_key}"
      )

      JSON.parse(resp.body)['settings']
    rescue => e
      Rails.logger.error e.message
    end
  end

  private

  def configured?
    host_url.present? && api_key.present?
  end

  def fetch_domain_config(host)
    return nil unless host.present?

    domain_key = host.gsub(".", "")
    Site::Config.domains&.[](domain_key) || Site::Config.domains&.send(domain_key)
  end

  def host_url
    return @host_url if defined?(@host_url)

    @host_url = begin
      domain_host = @domain_config&.host.presence
      if domain_host
        "#{domain_host}/ghost/api"
      else
        raise "Ghost API host not configured for domain: #{host}"
      end
    end
  end

  def api_key
    return @api_key if defined?(@api_key)

    @api_key = @domain_config&.key.presence
  end
end
