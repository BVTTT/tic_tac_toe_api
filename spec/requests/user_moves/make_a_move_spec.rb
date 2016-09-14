# frozen_string_literal: true

describe 'User moves' do
  include ResponseHelpers

  describe 'PUT /games/:id/user_moves' do
    context 'when its the users turn' do
      include_context :after_creating_an_easy_game

      let(:current_game) do
        Game.find(@game_id)
      end

      before do
        @game_id = parsed_body.dig(:data, :id)

        # Make cpu play
        put parsed_body.dig(:links, :current_player_moves)
      end

      context 'and the user plays in a valid position' do
        let(:player_move) { current_game.board.available_positions.first.to_a }

        let(:payload) do
          {
            data: {
              type: 'user_moves',
              attributes: {
                # Make sure to always play in an available position
                position: player_move
              }
            }
          }
        end

        it 'responds with 200' do
          put parsed_body.dig(:links, :current_player_moves), params: payload

          expect(response).to have_http_status(:ok)
        end

        it 'updates the board with the users move' do
          put parsed_body.dig(:links, :current_player_moves), params: payload

          expect(current_game.reload.board[*player_move]).to eq 'user'
        end
      end

      context 'and the user plays in an invalid position' do
        let(:payload) do
          {
            data: {
              type: 'user_moves',
              attributes: {
                # Make sure to always play in an unavailable position
                position: current_game.board.unavailable_positions.first.to_a
              }
            }
          }
        end

        it 'responds with 422' do
          put parsed_body.dig(:links, :current_player_moves), params: payload

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'responds with an appropriate error' do
          put parsed_body.dig(:links, :current_player_moves), params: payload

          expect(parsed_body.dig(:errors, 0, :title)).to eq 'invalid_move'
        end
      end
    end
  end
end
