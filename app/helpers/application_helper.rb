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

end
