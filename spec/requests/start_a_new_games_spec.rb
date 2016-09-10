# frozen_string_literal: true

describe 'start a new game' do
  describe 'POST /games' do
    before { post games_path, headers: { Host: 'tictactoe.api' } }

    it 'responds with a status code of 201' do
      expect(response).to have_http_status(201)
    end

    it 'responds with the created game location' do
      expect(response.location).to match(%r(^http://tictactoe\.api/games/\h{24}$))
    end

    it 'responds with the correct content-type' do
      expect(response.content_type).to eq 'application/json'
    end

    it 'responds with the created game representation' do
      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body.dig(:data, :type)).to eq 'games'
      expect(parsed_body.dig(:data, :id)).to match(/^\h{24}$/)
      expect(parsed_body.dig(:data, :attributes, :board)).to be_an(Array)
    end

    it 'responds with links' do
      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body.dig(:links, :self)).to match(%r(^http://tictactoe\.api/games/\h{24}$))
    end
  end
end
