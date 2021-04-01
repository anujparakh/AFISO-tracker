class OfficersController < ApplicationController

    def create
        @officer = Officer.new(:email => params[:officer][:email])
        if @officer.save
            flash[:notice] = "Added new officer email to Admins list"
        else
            flash[:error] = "Incorrect format for email"
        end

        redirect_to("/home/settings")
    end

    def update
    end

    def destroy
        p params
        @officer = Officer.find(params[:id])
        @officer.destroy
        redirect_to("/home/settings")
    end
end
