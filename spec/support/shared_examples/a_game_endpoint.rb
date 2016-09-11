shared_examples_for :a_game_endpoint do |current_player: 'cpu'|
  include ResponseHelpers

  it 'responds with the correct content-type' do
    expect(response.content_type).to eq 'application/json'
  end

  it 'responds with the created game representation' do
    expect(parsed_body.dig(:data, :type)).to eq 'games'
    expect(parsed_body.dig(:data, :id)).to match(/^\h{24}$/)
    expect(parsed_body.dig(:data, :attributes, :board)).to be_an(Array)
    expect(parsed_body.dig(:data, :attributes, :current_player)).to eq(current_player)
  end

  it 'responds with links' do
    expect(parsed_body.dig(:links, :self)).to match(%r(^http://tictactoe\.api/games/\h{24}$))
  end
end
