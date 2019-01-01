class WelcomeController < ApplicationController
  def index
    if(params[:q])
      @phone_number = params[:q]
    end
  end
end
