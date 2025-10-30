class PagesController < ApplicationController
	layout :resolve_layout

	before_action :set_settings

	def index
		@posts = ghost_client.get_data(:posts, page: params[:page] || 1)

		render "#{app_name}/pages/index", layout: "#{app_name}/layouts/application"
	end

	def show
		if page_exists?(request.path)
		  render "#{app_name}/pages#{request.path}"
		else
			@page = ghost_client.get_data(:page, slug: request.path)

			raise ActiveRecord::RecordNotFound, "Page not found" unless @page.present?
		end
	end

	private

	def resolve_layout
		if !page_exists?(request.path) && layout_exists?(:blog)
			"#{app_name}/layouts/blog"
		else
			"#{app_name}/layouts/application"
		end
	end
end
