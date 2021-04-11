# frozen_string_literal: true

class OfficersController < ApplicationController
  def create
    @officer = Officer.new(email: params[:officer][:email])
    if @officer.save
      flash[:notice] = 'Added new officer email to Admins list'
    else
      flash[:error] = 'Incorrect format for email'
    end

    redirect_to('/home/settings')
  end

  def update; end

  def destroy
    @officer = Officer.find(params[:id])
    if (Officer.all.count > 1)
      @officer.destroy
    else
      flash[:error] = "No one will have access to this app if all admins are deleted."
    end
    redirect_to('/home/settings')
  end
end
