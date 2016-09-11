# frozen_string_literal: true

describe 'complete a game', :complete_game do
  RANDOM_SEED = 7

  include ResponseHelpers

  def make_user_move!
    payload = {
      data: {
        type: 'user_moves',
        attributes: {
          # Make sure to always play in an available position
          position: user_moves.shift
        }
      }
    }

    put user_moves_path(current_game), params: payload
  end

  let(:current_game) { Game.find @game_id }

  let(:user_moves) do
    [
      # Try to win diagonally
      [0, 0],
      [0, 2],
      [0, 1]
    ]
  end

  before { Kernel.srand(RANDOM_SEED) }
  after { Kernel.srand }

  before do
    # Start a game
    post games_path

    @game_id = parsed_body.dig(:data, :id)
    @cpu_player_moves_url = parsed_body.dig(:links, :current_player_moves)

    # Cpu move
    put @cpu_player_moves_url

    # Make sure game is progressing as expected
    expect(parsed_body.dig(:related, :cpu_moves, :played_position)).to eq [1, 1]

    make_user_move!

    put @cpu_player_moves_url

    # Make sure game is progressing as expected
    expect(parsed_body.dig(:related, :cpu_moves, :played_position)).to eq [2, 0]

    make_user_move!

    put @cpu_player_moves_url

    # Make sure game is progressing as expected
    expect(parsed_body.dig(:related, :cpu_moves, :played_position)).to eq [1, 2]

    # Game over!
    make_user_move!
  end

  it 'reflects the state of the game on the payload' do
    expect(parsed_body.dig(:data, :attributes, :states, :is_over)).to be true
    expect(parsed_body.dig(:data, :attributes, :winner)).to eq 'user'
  end

  it 'does not include a "current_player_moves" link' do
    expect(parsed_body.dig(:links, :current_player_moves)).to be_nil
  end

  it 'does not allow further moves' do
    # attempt a cpu move
    put @cpu_player_moves_url

    expect(response).to have_http_status(:unprocessable_entity)
    expect(parsed_body.dig(:errors, 0, :title)).to eq 'invalid_move'

    make_user_move!

    expect(response).to have_http_status(:unprocessable_entity)
    expect(parsed_body.dig(:errors, 0, :title)).to eq 'invalid_move'
  end
end
