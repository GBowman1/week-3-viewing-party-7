class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
  end 

  # def create 
  #   user = User.create!(user_params)
  #   # if user_params[:password] == user_params[:password_confirmation]
  #     if user.save
  #       redirect_to user_path(user)
  #     else  
  #       flash[:error] = user.errors.full_messages.to_sentence
  #       redirect_to register_path
  #     end 
  #   # else
  #     # flash[:error] = "Password confirmation doesn't match Password"
  #     # redirect_to register_path
  #   # end
  # end 

  def create 
    begin 
      user = User.create!(user_params)
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
end 