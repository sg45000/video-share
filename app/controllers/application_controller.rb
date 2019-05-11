class ApplicationController < ActionController::Base
    include SessionsHelper
    include UsersHelper

    def logged_in_user?
        unless logged_in?
          flash[:danger] = "Please log in your account before access this page." 
          redirect_to login_url
        end
    end
end
