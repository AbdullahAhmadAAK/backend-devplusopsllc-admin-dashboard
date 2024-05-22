class User < ApplicationRecord
    has_secure_password
    
    enum user_type: { type1: 1, type2: 2 }

    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true, length: { minimum: 6 }
    validates :name, presence: true

    def generate_jwt_token
        # TODO: need to turn this into proper JWT, and save that JWT in a table of tokens so that we can check with that whenever user sends any request to APIs
        token = "tok_number_#{id}"
        Token.find_or_create_by(user_id: id, token: token)
        token
    end
end
