require 'rails_helper'

RSpec.describe "Tickets API", type: :request do
  let(:valid_params) do
    {
      user_id: 1,
      title: 'Test Ticket',
      tags: ['Ruby', 'rails']
    }
  end

  it 'creates a ticket and counts tags' do
    post '/api/tickets', params: valid_params.to_json, headers: { 'Content-Type' => 'application/json' }

    expect(response).to have_http_status(:created)
    expect(Ticket.count).to eq(1)
    expect(Tag.find_by(name: 'ruby')&.count).to eq(1)
    expect(Tag.find_by(name: 'rails')&.count).to eq(1)
  end

  it 'returns 422 on missing user_id' do
    post '/api/tickets', params: valid_params.except(:user_id).to_json, headers: { 'Content-Type' => 'application/json' }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(JSON.parse(response.body)['errors']).to include('user_id is required')
  end

  it 'returns 422 on more than 4 tags' do
    post '/api/tickets', params: valid_params.merge(tags: %w[a b c d e]).to_json, headers: { 'Content-Type' => 'application/json' }

    expect(response).to have_http_status(:unprocessable_entity)
    expect(JSON.parse(response.body)['errors']).to include('tags must be fewer than 5')
  end
end
