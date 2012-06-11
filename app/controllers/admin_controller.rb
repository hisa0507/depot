class AdminController < ApplicationController
  def index
    @user = User.order(:name)
  end
end
