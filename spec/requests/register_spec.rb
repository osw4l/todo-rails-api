require 'swagger_helper'

RSpec.describe 'register', type: :request do

  path '/auth/register' do

    post('sign_up register') do
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
