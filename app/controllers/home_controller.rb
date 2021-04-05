# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def help; end

  def settings
    @officers = Officer.order('email ASC')
    @officer = Officer.new
  end
end
