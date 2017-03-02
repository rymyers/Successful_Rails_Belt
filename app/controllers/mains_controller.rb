class MainsController < ApplicationController
  def index
  end
  def new
      user = User.new(user_params)
      if user.save
          session[:user_id] = user.id
          redirect_to "/groups"
      else
          flash[:errors] = user.errors.full_messages
          redirect_to :back
      end
  end

  def login
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to '/groups'
      else
          flash[:errors] = ["Invalid Combination"]
          redirect_to :back
      end
  end

  def logout
      reset_session
      redirect_to :root
  end

  def groups
      if session[:user_id]
         @user = User.find_by(id:(session[:user_id]))
         @groups = Group.all
     else
         redirect_to :root
    end
  end

  def org
      if session[:user_id]
          @isamember = 100
          @user = User.find_by(id:(session[:user_id]))
          @group = Group.find(params[:id])
          @members = Member.where(group_id:params[:id])
          if !Member.find_by(user_id:session[:user_id],group_id:params[:id])
              @isamember = 0
          else
              @isamember = 2
          end
      else
          redirect_to :root
     end
  end

  def leave
      member = Member.find_by(user_id:params[:user_id],group_id:params[:group_id]).destroy
      number = Group.find(params[:group_id]).members
      Group.find(params[:group_id]).update(members:number - 1)
      redirect_to :back
  end

  def delete
      Group.find_by(id:params[:id]).destroy
      redirect_to :back
  end

  private

  def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
