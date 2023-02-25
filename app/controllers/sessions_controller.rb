class SessionsController < ApplicationController
    def new
    end

    def create
        #check if the user exists
        @user = User.find_by({"email" => params["email"]})
        if @user
            #if they do, check that they  know their password
            #if params["password"] == @user["password"]
            if BCrypt::Password.new(@user["password"]) == params["password"]
                cookies["monster"] = "me like cookies"
                session["user_id"] = @user["id"]
            #if they do, send them in
                flash["notice"] = "Welcome!"
                redirect_to "/companies"  
            else
                redirect_to "/sessions/new" 
            end    
        else
            redirect_to "/sessions/new"
        end
    end

    def destroy
        session["user_id"] = nil
        redirect_to "/sessions/new"
    end
end
