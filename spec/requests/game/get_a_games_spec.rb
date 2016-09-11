# frozen_string_literal: true

describe 'start a new game' do
  describe 'GET /games/:id' do
    context 'when game exists' do
      include_context :after_creating_an_easy_game

      before do
        game_location = response.location

        get game_location
      end

      it_behaves_like :a_game_endpoint

      it 'responds with 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when game doesnt exist' do
      include ResponseHelpers

      before do
        get game_path(id: 'some-unknown')
      end

      it 'responds with 404' do
        expect(response).to have_http_status(:not_found)
      end

      it 'responds with an error' do
        expect(parsed_body.dig(:errors, 0, :title)).to eq 'not_found'
        expect(parsed_body.dig(:errors, 0, :detail)).to eq 'Game with id: "some-unknown" could not be found'
      end
    end
  end
end
