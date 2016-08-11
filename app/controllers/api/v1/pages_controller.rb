module Api
  module V1
    class PagesController < ApplicationController
      respond_to :json

      # GET /pages
      # GET /pages.json
      def index
        respond_with Page.all
      end

      # GET /pages/1
      # GET /pages/1.json
      def show
        respond_with Page.find(params[:id])
      end

      # POST /pages
      # POST /pages.json
      def create
        url = params[:url] || params[:page][:url]
        page = Page.find_or_initialize_by(url: url)
        page.parsing = true
        page.page_elements = []
        if page.save
          Resque.enqueue(PageParserWorker, page.id)
          render json: page, status: 201, location: [:api, :v1, page]
        else
          render json: { errors: page.errors }, status: 422
        end
      end

      # DELETE /pages/1
      # DELETE /pages/1.json
      def destroy
        page = Page.find(params[:id])
        page.destroy
        head 204
      end

      private

        def page_params
          params.require(:page).permit(:url)
        end
    end
  end
end
