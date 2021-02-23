class HomeController < ApplicationController
  before_action :check_for_lockup

  def index
  end

  def help
  end

  def security
  end
end
