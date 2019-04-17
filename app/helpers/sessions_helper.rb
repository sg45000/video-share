module SessionsHelper
    
        def log_in user
          session[:user_id] = user.id
        end
      
        def current_user
          if user_id = session[:user_id]
            @current_user ||= User.find_by(id: user_id)
          elsif user_id = cookies.signed[:user_id]
            user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remenber_token])
              log_in user
              @current_user = user
            end
          end
        end
      
        def logged_in?
          !current_user.nil?
        end
      
        def forget user
          user.forget
          cookies.delete(:remenber_token)
          cookies.delete(:user_id)
        end
      
        def logout
          forget(current_user)
          session.delete(:user_id)
          @current_user=nil
        end
      
        def remenber(user)
          user.remenber
          cookies.permanent[:remenber_token] = user.remenber_token
          cookies.permanent.signed[:user_id] = user.id
        end
end
