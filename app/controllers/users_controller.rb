class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :index]
  before_filter :require_admin, :only => [:destroy, :new, :create]
  before_filter :set_current_tab

  def new
    @user = User.new
    render :layout => 'user_sessions'
    respond_to do |format|
      format.html # new.html.erb
      format.js # index.html.erb
      format.xml { render :xml => @user }
    end
  end

  def index

    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.xml { render :xml => @users }
    end
  end

  def upd
    @user= User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def report
    day_report
  end
  def day_report
    @user= User.find(params[:id])
    @user.date =  Date.parse(params[:date])
    respond_to do |format|
      format.js
    end
  end


  def clear
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # index.html.erb
    end
  end

  def create
=begin
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = 'User created successfully!'
      redirect_to(users_url)
    else
      render :action => :new, :layout => 'user_sessions'
    end

=end
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
        format.js { render :action => 'create_error' }
      end
    end

  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html #show.html.erb
      format.xml { render :xml => @user }
    end
  end

  def edit
    if @current_user.admin
      @user = User.find(params[:id])
    else
      @user = @current_user
    end
    respond_to do |format|
      format.html # new.html.erb
      format.js # index.html.erb
    end

  end


  def update
    if @current_user.admin?
      @user = lookup_user
    else
      @user = @current_user
    end
=begin

    if @user.update_attributes(params[:user])
      flash[:success] = 'Account updated successfully!'
      #redirect_to user_path(@user.id)
      redirect_to(users_url)
    else
      render :action => :edit
    end
=end
    @user= User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:room])
        format.html { redirect_to(users_url, :notice => 'User was successfully updated.') }
        format.js { render :action => 'updated' }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
        format.js { render :action => 'create_error' }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end
  end

  def users_destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "deleted room."
      redirect_to users_url
    else
      render :action => 'index'
    end
  end

  private

  def lookup_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error(":::Attempt to access invalid user_id => #{params[:id]}")
      flash[:error] = 'You have requested an invalid user!'
      redirect_to users_path
    end
  end

  def set_current_tab
    @current_tab = :users
  end

end
