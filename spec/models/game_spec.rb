# frozen_string_literal: true

describe Game do
  describe '#make_move!' do
    it 'updates the board' do
      subject.make_move! [0, 0]

      expect(subject.board[0, 0]).to eq 'cpu'
    end

    it 'sets the next player' do
      subject.make_move! [0, 0]

      expect(subject.current_player).to eq 'user'
    end

    it 'saves the game' do
      subject.make_move! [0, 0]

      subject.reload

      expect(subject.current_player).to eq 'user'
      expect(subject.board[0, 0]).to eq 'cpu'
    end
  end

  describe '#has_winner?' do

    it 'returns false by default' do
      expect(subject).not_to have_winner
    end

    context 'when a row has one unique value' do
      before do
        subject.board[0, 0] = 'user'
        subject.board[1, 0] = 'user'
        subject.board[2, 0] = 'user'
      end

      it 'return true' do
        expect(subject).to have_winner
      end
    end

    context 'when a column has one unique value' do
      before do
        subject.board[0, 0] = 'user'
        subject.board[0, 1] = 'user'
        subject.board[0, 2] = 'user'
      end

      it 'return true' do
        expect(subject).to have_winner
      end
    end

    context 'when a diagonal has one unique value' do
      before do
        subject.board[0, 0] = 'user'
        subject.board[1, 1] = 'user'
        subject.board[2, 2] = 'user'
      end

      it 'return true' do
        expect(subject).to have_winner
      end
    end
  end

  describe '#deadlocked?' do
    it 'return true when the game is deadlocked' do
      subject.board[0, 0] = 'user'
      subject.board[1, 0] = 'cpu'
      subject.board[2, 0] = 'user'

      subject.board[0, 1] = 'cpu'
      subject.board[1, 1] = 'cpu'
      subject.board[2, 1] = 'user'

      subject.board[0, 2] = 'cpu'
      subject.board[1, 2] = 'user'
      subject.board[2, 2] = 'cpu'

      expect(subject.is_deadlocked?).to be true
    end
  end

  describe '#winner' do
    context 'when there is a winner' do
      it 'returns the winner' do
        subject.board[0, 1] = 'cpu'
        subject.board[1, 1] = 'cpu'
        subject.board[2, 1] = 'cpu'

        expect(subject.winner).to eq 'cpu'
      end
    end

    context 'when there is not a winner' do
      it 'returns nil' do
        expect(subject.winner).to be_nil
      end
    end
  end
end
