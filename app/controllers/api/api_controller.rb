module Api
    class ApiController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :process_token

        private

        def process_token
            # if token not valid, don't let user proceed!
            render json: { errors: ["Invalid token used!"] }, status: :unauthorized unless request.authorization == ENV['ACCESS_TOKEN']
        end
    end    
end