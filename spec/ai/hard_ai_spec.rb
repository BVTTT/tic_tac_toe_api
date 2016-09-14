# frozen_string_literal: true

describe HardAI do
  describe '#decide' do
    let(:board) do
      Board.new
    end

    let(:ai1) { described_class.new(board, player_name: 'ai1') }
    let(:ai2) { EasyAI.new(board) }

    it 'tries to wins' do
      move = ai1.decide
      board[move[0], move[1]] = 'ai1'

      move = ai2.decide
      board[move[0], move[1]] = 'ai2'

      move = ai1.decide
      board[move[0], move[1]] = 'ai1'

      move = ai2.decide
      board[move[0], move[1]] = 'ai2'

      move = ai1.decide
      board[move[0], move[1]] = 'ai1'

      move = ai2.decide
      board[move[0], move[1]] = 'ai2'

      move = ai1.decide
      board[move[0], move[1]] = 'ai1'

      expect(GameRules.find_winner(board)).to eq 'ai1'
    end
  end
end
