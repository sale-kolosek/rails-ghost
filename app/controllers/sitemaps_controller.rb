class SitemapsController < ApplicationController
  def show
    sitemap_file = case request.host
                   when 'ruby.ci'
                      'sitemap_ruby_ci.xml.gz'
                   when 'litetracker.com'
                     'sitemap_litetracker.xml.gz'
                   end

    path = Rails.root.join('public', sitemap_file)

    if File.exist?(path)
      send_file path, type: 'application/gzip', disposition: 'inline'
    else
      render plain: "Sitemap not found", status: :not_found
    end
  end
end
