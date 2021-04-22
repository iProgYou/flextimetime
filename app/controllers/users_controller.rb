class UsersController < ApplicationController

    def index
        users = User.all

        render json: users
    end

    def show
        user = User.find_by(id: params[:id])

        render json: user
    end

    def create
        user = User.new(user_params)

        if user.save
            redirect_to user_url(user)
        else
            render json: user.errors.full_messages
        end

    end

    private

    def user_params
        params.require(:user).permit(:username,:email)
    end
end
