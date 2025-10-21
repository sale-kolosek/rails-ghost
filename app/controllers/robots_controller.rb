class RobotsController < ApplicationController
  def show
    content = case request.host
              when 'litetracker.com'
                <<~ROBOTS
                  User-agent: *
                  Disallow:

                  Sitemap: https://#{request.host}/sitemap_litetracker.xml.gz
                ROBOTS

              when 'ruby.ci'
                <<~ROBOTS
                  User-agent: *
                  Disallow:

                  Sitemap: https://#{request.host}/sitemap_ruby_ci.xml.gz
                ROBOTS

              else
                "User-agent: *\nDisallow: /"
              end

    render plain: content, content_type: 'text/plain'
  end
end
