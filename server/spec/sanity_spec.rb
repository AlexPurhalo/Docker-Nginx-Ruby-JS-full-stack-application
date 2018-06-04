describe 'GET /notes' do
  before do
    Note.create(body: 'hello world :)')
    Note.create(body: 'hello again :)')
  end

  before do
    get '/api/v1/notes'
  end

  subject do
    JSON.parse(last_response.body, symbolize_names: true)
  end

  it do
    is_expected.to include(
      include(
        body: 'hello world :)',
        body: 'hello again :)'
      )
    )
  end
end
