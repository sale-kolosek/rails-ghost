# frozen_string_literal: true

class BlockMaliciousRequests
  BLOCKED_EXTENSIONS = %w[
    .php .asp .aspx .jsp .cgi .pl .py .sh .bash
    .exe .dll .bat .cmd .com .msi
    .env .git .svn .htaccess .htpasswd
  ].freeze

  BLOCKED_PATHS = %w[
    /wp-admin /wp-login /wp-content /wp-includes /wordpress
    /administrator /admin.php /admincp
    /phpmyadmin /pma /myadmin /mysql
    /xmlrpc.php /wp-xmlrpc.php
    /cgi-bin /scripts /shell
    /.well-known/security.txt
    /config.php /configuration.php /settings.php
    /backup /db /database /sql
    /vendor /node_modules
    /actuator /manager /jmx-console
    /solr /jenkins /hudson
    /telescope /nova
    /elmah.axd /trace.axd
  ].freeze

  def initialize(app)
    @app = app
  end

  def call(env)
    path = env["PATH_INFO"].to_s.downcase

    if blocked_request?(path)
      Rails.logger.info("[BLOCKED] Malicious request: #{path} from #{env['REMOTE_ADDR']}")
      return [404, { "Content-Type" => "text/plain" }, ["Not Found"]]
    end

    @app.call(env)
  end

  private

  def blocked_request?(path)
    blocked_by_extension?(path) || blocked_by_path?(path)
  end

  def blocked_by_extension?(path)
    BLOCKED_EXTENSIONS.any? { |ext| path.end_with?(ext) }
  end

  def blocked_by_path?(path)
    BLOCKED_PATHS.any? { |blocked| path.start_with?(blocked) }
  end
end
