# frozen_string_literal: true

describe 'start a new game' do
  describe 'POST /games' do
    before { post games_path, headers: { Host: 'tictactoe.api' } }
    it_behaves_like :a_game_endpoint

    it 'responds with a status code of 201' do
      expect(response).to have_http_status(:created)
    end

    it 'responds with the created game location' do
      expect(response.location).to match(%r(^http://tictactoe\.api/games/\h{24}$))
    end
  end
end
