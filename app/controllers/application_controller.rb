class ApplicationController < ActionController::API
    SECRET = "yoursecretword"
    
    # way to authenticate: token decoding 
    def authentication
      decode_data = decode_user_data(request.headers["token"])
      user_data = decode_data[0]["user_id"] unless !decode_data
      user = User.find(user_data&.id)
    
      if user
        return true
      else
        render json: { message: "invalid credentials" }
      end
    end

    def encode_user_data(payload)
        JWT.encode payload, SECRET, "HS256"
    end
    
    def decode_user_data(token)
        begin
            JWT.decode token, SECRET, true, { algorithm: "HS256" }
        rescue => e
            puts e
        end
    end

    def current_user
        if decoded_token
            # data = decoded_token
            user_data = decoded_token[0]["user_data"]
            user = User.find_by(id: user_data)
            #   user = User.find_by(id: data[:user_id])
            if user
                @current_user ||= user
            end
        end
    end
    def decoded_token
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        if header
            begin
                JWT.decode header, SECRET, true, { algorithm: "HS256" }
            rescue Error => e
                return render json: {error: [e.message]}, status: :unauthorized
            end
        end
    end

    def current_cart
		Cart.find(session[:cart_id])
	    rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end

    # find current cart with token
    # def current_cart
    #     if decoded_token
    #         cart_data = decoded_token[0]["user_data"]
    #         cart = Cart.find_by(id: cart_data)
    #         if cart
    #             @current_cart ||= cart
    #         end
    #     end
    # end

end

# code that can run in every controller