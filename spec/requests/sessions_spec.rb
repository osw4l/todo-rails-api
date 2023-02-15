require 'swagger_helper'

RSpec.describe 'sessions', type: :request do

  path '/login' do
    parameter email: "user@example.com", password:
    post('create session') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
