shared_context :request do
  let(:parsed_body) { JSON.parse(response.body, symbolize_names: true) }
end
