describe Board do
  subject { described_class.new(size: 3) }

  describe '#diagonals' do
    before do
      # left diagonals
      subject[0, 0] = 1
      subject[2, 2] = 3

      subject[1, 1] = 2

      # right diagonals
      subject[0, 2] = 4
      subject[2, 0] = 5
    end

    it 'returns elements diagonally places on the board' do
      simplified_diagonals = subject.diagonals.map do |set|
        set.map(&:value)
      end

      expect(simplified_diagonals).to eq [[1, 2, 3], [4, 2, 5]]
    end
  end

  describe '#[x, y]=' do
    it 'sets the given position' do
      subject[0, 0] = :x
      subject[0, 1] = :o
      subject[2, 2] = :y

      expect(subject[0, 0]).to be :x
      expect(subject[0, 1]).to be :o
      expect(subject[2, 2]).to be :y
    end

    it 'does not allow the use of indexes out of the board range' do
      expect { subject[-1, 1] = :x }.to raise_error(Board::OutOfBoundsError)
    end

    it 'does not allow the use of index that is already taken' do
      subject[1, 1] = :o
      expect { subject[1, 1] = :x }.to raise_error(Board::OutOfBoundsError)
    end
  end

  describe '#available_positions' do
    it 'returns a of the available positions' do
      expect(subject.available_positions.map(&:to_a)).to eq [
        [0, 0], [1, 0], [2, 0],
        [0, 1], [1, 1], [2, 1],
        [0, 2], [1, 2], [2, 2],
      ]
      subject[1, 1] = :x

      expect(subject.available_positions.map(&:to_a)).to eq [
        [0, 0], [1, 0], [2, 0],
        [0, 1],         [2, 1],
        [0, 2], [1, 2], [2, 2],
      ]
    end
  end
end
