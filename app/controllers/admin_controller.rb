class AdminController < ApplicationController
  before_filter :require_admin, :set_current_tab

  def index
  end

  def add_user
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:success] = "User #{@user.username} was successfully created!"
        format.html { redirect_to admin_index_path }
      else

        @initial_tab_index = 3
        format.html { render :action => 'index' }
      end
    end
  end

   def destroy_room
    @room= Room.find(params[:id])

    respond_to do |format|
      if @room.destroy
        flash[:success] = "Room #{@user.number} was successfully deleted!"
        format.html { redirect_to admin_index_path }
      else
        #set initial tab to display errors...must match tab position in index view
        #@initial_tab_index = 3
        format.html { render :action => 'index' }
      end
    end
  end
  private

  def set_current_tab
    @current_tab = :admin
  end

end
