module Api
  class ArtistsController < Api::BaseController

    private

      def artist_params
        params.require(:artist).permit(:name)
      end

      def query_params
        params.permit(:name)
      end

  end
end
