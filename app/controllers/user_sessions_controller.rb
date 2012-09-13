class UserSessionsController < ApplicationController
before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      msg = "Welcome #{@user_session.user.username}!"
      flash[:success] = msg
      redirect_back_or_default dashboard_index_path
    else
      if @user_session.being_brute_force_protected?
        #flash[:error] = t('locked_out')
      else
        flash[:message] = 'invalid login'
      end
      redirect_to login_path
    end

  end

  def destroy
    current_user_session.destroy
    flash[:success] = "logged out"
    redirect_back_or_default login_path
  end

end
