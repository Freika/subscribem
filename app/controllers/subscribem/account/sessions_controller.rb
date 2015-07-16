require_dependency "subscribem/application_controller"

module Subscribem
  class Account::SessionsController < Subscribem::ApplicationController
    def new
      @user = User.new
    end

    def create
      if env['warden'].authenticate(scope: :user)
        flash[:notice] = 'You are now signed in.'
        redirect_to root_path
      else
        @user = User.new
        flash[:error] = 'Invalid email or password.'
        render :new
      end
    end
  end
end
