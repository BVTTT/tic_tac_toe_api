# frozen_string_literal: true

describe 'End a game' do
  describe 'DELETE /games/:id' do
    describe 'when game exists' do
      include_context :after_creating_an_easy_game

      before do
        @game_location = response.location

        delete @game_location
      end

      it 'responds with with a 204' do
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes a game' do
        get @game_location

        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'when game doesnt exists' do
      before do
        delete game_path('unknown-game')
      end

      it 'responds with with a 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
