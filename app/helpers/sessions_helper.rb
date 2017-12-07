module SessionsHelper
    # Logs in the given user
    def log_in(user)
        session[:user_id] = user.id
    end
     # Remembers a user in a persistent session.
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    # returns current user logged in user if any?
    def current_user
        # this checks whether the user has forexample closed the browser and 
        # remember it is not a comparison but an assignment
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
            # if the user has closed the browser then check for the permanent cookie
            elsif (user_id = cookies.signed[:user_id])
                # pick that user with the same id as the one in the database
            user = User.find_by(id: user_id)
            # if the user is there then use the authenticated method to compare the remember_token
            # in the cookie and the remember_digest encrypted version
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end
     # Forgets a persistent session.
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
      # Logs out the current user.
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
end
