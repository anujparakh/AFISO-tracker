# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def help; end

  def settings
    @officers = Officer.order('email ASC')
    @officer = Officer.new

    if params[:theme] != nil
      if params[:theme] == "dark"
        cookies[:theme] = "dark"
      else
        cookies[:theme] = "light"
      end
      flash[:notice] = "Changed to " + cookies[:theme] + " mode"
    end
  end
end
