class BlogsController < ApplicationController
	layout :resolve_layout
	before_action :set_settings

	def index
		@posts = ghost_client.get_data(:posts, page: params[:page] || 1)

		if blog_override_exists?(:index)
			render "#{app_name}/blogs/index"
		end
	end

	def show
		@post = ghost_client.get_data(:post, path: request.path)

		if @post.present?
			if blog_override_exists?(:show)
				render "#{app_name}/blogs/show"
			end
		else
			raise ActiveRecord::RecordNotFound, "Post not found"
		end
	end

	private

	def resolve_layout
		layout_exists?(:blog) ? "#{app_name}/layouts/blog" : "#{app_name}/layouts/application"
	end
	
	def blog_override_exists?(file_name)
	  lookup_context.template_exists?("#{app_name}/blogs/#{file_name}", [], false)
	end

end
