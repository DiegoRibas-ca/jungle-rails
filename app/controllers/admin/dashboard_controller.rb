class Admin::DashboardController < ApplicationController
  # before_filter :authorize_admin
  http_basic_authenticate_with name: ENV['USERADMIN'], password: ENV['PASSWORD']
  def show
  end
end
