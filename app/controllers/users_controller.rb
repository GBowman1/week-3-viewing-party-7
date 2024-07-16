class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create 
    begin 
      user = User.create!(user_params)
      session[:user_id] = user.id
      user.save
      redirect_to user_path(user)
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = e.message
      redirect_to register_path
    end
  end

  def login
    
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      cookies[:location] = params[:location]
      redirect_to user_path(user)
    else 
      flash[:error] = "Invalid email or password"
      redirect_to login_path
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 

  def require_user
    if !current_user
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
    end
  end
end 