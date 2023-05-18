class Api::V1::UsersController < ApplicationController
    def login
        @user = User.find_by(email: params[:email])

        if @user && @user.password == params[:password]
            token = encode_user_data({ user_data: @user.id })
            render json: { token: token, message: "Valid user" }
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

    private

    def user_params
        params.permit(:email, :password)
    end
end
