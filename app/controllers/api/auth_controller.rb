module Api
    class AuthController < Api::ApiController

        before_action :set_user, only: [:login]
        def login
            user_details = { name: @user.name, email: @user.email, token: @user.generate_jwt_token}
            render json: { user: user_details }, status: :ok
        end

        def signup
            user = User.new(user_params)
            if user.save
                render json: { message: 'User signed up successfully!', errors: [] }, status: :ok
            else
                render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
            end
        end

        private

        def set_user
            # TODO I can also encode the password for safety. I tried this but BCrypt was giving issues 
            # error was invalid hash when trying to sign up. So I decided to implement the essentials first.
            @user = User.find_by(email: user_params[:email]) 
            return render json: { errors: ["User does not exist!"] }, status: :unprocessable_entity unless @user.present?

            encoded_password = user_params[:password_digest]
            render json: { errors: ["User email and password don't match!"] }, status: :unprocessable_entity unless @user.password_digest == encoded_password
        end

        def user_params
            params.require(:user).permit(:name, :email, :password_digest, :user_type)
        end
    end    
end