shared_context :after_creating_an_easy_game do
  let(:create_game_payload) do
    {
      data: {
        type: :games,
        attributes: {
          difficulty: :easy
        }
      }
    }
  end

  before { post games_path, params: create_game_payload }
end
