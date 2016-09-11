# frozen_string_literal: true

describe Game do
  describe '#make_move!' do
    context 'when the right player tries to play' do
      it 'updates the board' do
        subject.make_move! [0, 0]

        expect(subject.board[0, 0]).to eq 'cpu'
      end

      it 'sets the next player' do
        subject.make_move! [0, 0]

        expect(subject.current_player).to eq 'user'
      end
    end
  end
end
