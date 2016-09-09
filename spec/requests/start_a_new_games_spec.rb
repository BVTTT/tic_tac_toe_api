describe 'start a new game' do
  describe 'POST /games' do
    before { post games_path }

    it 'responds with a status code of 201' do
      expect(response).to have_http_status(201)
    end

    it 'responds with the created game location' do
      expect(response.location).to match(/\/games\/\h{24}$/)
    end

    it 'responds with the correct content-type' do
      expect(response.content_type).to eq 'application/json'
    end

    it 'responds with the created game representation' do
      parsed_body = JSON.parse(response.body, symbolize_names: true)

      expect(parsed_body.dig(:data, :type)).to eq 'games'
      expect(parsed_body.dig(:data, :id)).to match(/^\h{24}$/)
      expect(parsed_body.dig(:data, :attributes, :board)).to be_an(Array)
    end
  end
end
