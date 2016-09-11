# frozen_string_literal: true

describe 'start a new game' do
  describe 'POST /games' do
    include_context :after_creating_an_easy_game
    it_behaves_like :a_game_endpoint

    it 'responds with a status code of 201' do
      expect(response).to have_http_status(:created)
    end

    it 'responds with the created game location' do
      expect(response.location).to match(%r(^http://www\.example\.com/games/\h{24}$))
    end
  end
end
