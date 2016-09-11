# frozen_string_literal: true

describe MovesController do
  include ResponseHelpers

  let(:game) { Game.create }

  before do
    game.apply_ai_driven_move!
  end

  describe 'PUT apply_user_move' do
    context 'when given an invalid resource type' do
      before do
        put :apply_user_move, params: { id: game.id, data: { type: 'not_user_moves' } }
      end

      it 'responds with an appropriate error' do
        expect(parsed_body.dig(:errors, 0, :title)).to eq 'invalid_payload'
        expect(parsed_body.dig(:errors, 0, :detail)).to include 'expected "user_moves"'
      end
    end

    context 'when given an invalid resource type' do
      before do
        put :apply_user_move, params: { id: game.id, data: { type: :user_moves, attributes: { position: nil }} }
      end

      it 'responds with an appropriate error' do
        expect(parsed_body.dig(:errors, 0, :title)).to eq 'invalid_payload'
        expect(parsed_body.dig(:errors, 0, :detail)).to include 'expected Array([x, y])'
      end
    end
  end
end
