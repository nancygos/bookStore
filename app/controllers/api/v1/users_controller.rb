class Api::V1::UsersController < ApplicationController

    # check authentication
    def login
        @user = User.find_by(email: params[:email])

        # 0 -> Normal user , 1 -> Admin
        if @user && @user.password == params[:password] && @user.role == 0
            token = encode_user_data({ user_data: @user.id })
            render json: { token: token, message: "User logged in successfully" }
        elsif @user && @user.password == params[:password] && @user.role == 1
            token = encode_user_data({ user_data: @user.id })
            render json: { token: token, message: "Admin logged in successfully" }
        else
            render json: { message: "invalid credentials" }
        end
    end

    def signup
        @user = User.new(user_params)
        if @user.save
            token = encode_user_data({ user_data: @user.id })
            render json: { token: token, message: "User created successfully" }
        else
            render json: { message: "invalid credentials" }
        end
    end

    def logout
        if current_user
            session.delete(:user_id)
            render json: {message: "Admin logged out successfuly."}
        end
    end

    private

    def user_params
        params.permit(:email, :password)
    end
end
