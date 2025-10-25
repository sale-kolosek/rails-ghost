class BlogsController < ApplicationController
	before_action :set_settings

	def index
		@posts = ghost_client.get_data(:posts, page: params[:page] || 1)

		render layout: "#{@app}/layouts/blog"
	end

	def show
		@post = ghost_client.get_data(:post, path: request.path)

		render layout: "#{@app}/layouts/blog"
	end
end
