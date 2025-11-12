module ApplicationHelper
	def resolve_title_metadata(path)
		slug = path.sub(/^\//, '')
		page_metadata = PageMetadata.find_by_slug(slug)
		page_metadata.meta_title if page_metadata.present?
	end

	def fix_missing_img_alts(html, alt)
	  doc = Nokogiri::HTML.fragment(html)

	  doc.css('img').each do |img|
	    if img['alt'].blank?
	      img['alt'] = alt
	    end
	  end

	  doc.to_html
	end

	def app_login_url_with_utm(base_url)
	  utm_params = {
	    utm_source:   session[:utm_source],
	    utm_medium:   session[:utm_medium],
	    utm_term:     session[:utm_term],
	    utm_content:  session[:utm_content],
	    utm_campaign: session[:utm_campaign]
	  }.compact_blank

	  uri = URI(base_url)
	  uri.query = utm_params.to_query if utm_params.any?
	  uri.to_s
	end
end
