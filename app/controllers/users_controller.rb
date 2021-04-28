class UsersController < ApplicationController

    #3 wasy to get stuff into params

    def index
        # limit query string
        # debugger
        @users = User.all
        if params[:limit]
            limit = params[:limit].to_i
            render :index
        else
            render :index
        end
    end

    def show
        user = User.find_by(id: params[:id])
        if user.nil?
            render json: 'user not found', status: 404
            return nil
        end
        render json: user
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            # redirect_to "/users/#{user.id}"
            login!(@user)
            redirect_to users_url
        else
            render :new
        end

    end

    # update

    def update
        user = User.find_by(id: params[:id])
        if user.nil?
            render json: 'user not found', status: 404
            return nil
        end
        if user.update(user_params)
            redirect_to user_url(user)
        else
            render json: user.errors.full_messages, status: 422
        end
    end

    # destroy
    def destroy
        user = User.find_by(id: params[:id])
        if user.nil?
            render json: 'user not found', status: 404
            return nil
        end
        user.destroy
        render json: user
    end

    private

    def user_params
        params.require(:user).permit(:username,:email,:password)
    end
end
