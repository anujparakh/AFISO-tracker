# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action raise: false
  before_action :authenticate_admin!
end
