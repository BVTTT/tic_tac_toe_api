# frozen_string_literal: true

describe 'Cpu moves' do
  include_context :request

  describe 'PUT /games/:id/cpu_moves' do
    describe 'make a cpu move' do
      before do
        post games_path, headers: { Host: 'tictactoe.api' }

        @cpu_moves_path = parsed_body.dig(:links, :current_player_moves)
      end

      context 'when its the cpu turn' do
        before do
          put @cpu_moves_path, headers: { Host: 'tictactoe.api' }
        end

        it_behaves_like :a_game_endpoint, current_player: 'user'

        it 'responds with 200' do
          expect(response).to have_http_status(:ok)
        end

        it 'includes the cpu move in the payload' do
          expect(parsed_body.dig(:related, :cpu_moves, :played_position)).to be_an(Array)
          expect(parsed_body.dig(:related, :cpu_moves, :played_position).length).to be 2
        end
      end

      context 'when its the users turn' do
        before do
          put @cpu_moves_path, headers: { Host: 'tictactoe.api' }

          put @cpu_moves_path, headers: { Host: 'tictactoe.api' }
        end

        it 'responds with 422' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns an appropriate error' do
          expect(parsed_body.dig(:errors, 0, :title)).to eq 'wrong_player'
        end
      end
    end
  end
end
