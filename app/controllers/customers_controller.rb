class CustomersController < ApplicationController
  before_filter :load
  before_filter :require_user
  before_filter :set_current_tab
  before_filter :require_admin, :only => [:destroy]

  def load
    @customers = Customer.all
    @customer = Customer.new

  end

  def index
    @customers = Customer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @customers }
    end
  end

  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.xml
  def new
    @customer = Customer.new

    respond_to do |format|
      format.js # index.html.erb
      format.html { redirect_to(customers_url) }
      format.xml { render :xml => @customer }
    end
  end

  def clear
    @customer = Customer.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # index.html.erb
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.js # index.html.erb
    end
  end

  def upd
    @customer = Customer.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # POST /customers
  # POST /customers.xml
  def create
    @customer = Customer.new(params[:customer])
    respond_to do |format|
      if @customer.save
        format.html { redirect_to(@customer, :notice => 'Customer was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
        format.js { render :action => 'create_error' }
      end
    end

  end

  # PUT /customers/1
  # PUT /customers/1.xml
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to(customers_url, :notice => 'Customer was successfully updated.') }
        format.js { render :action => 'updated' }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @customer.errors, :status => :unprocessable_entity }
        format.js { render :action => 'create_error' }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.xml
  def destroy

    @customer = Customer.find(params[:id])
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to(customers_url) }
      format.xml { customers :ok }
    end
  end

  def customers_destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      flash[:notice] = "Successfully created customer."
      redirect_to customers_url
    else
      render :action => 'index'
    end
  end

  def customer_search
    @customers = Customer.search(param[:search])
    @room_id = param[:room_id]
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @customers }
    end
  end

  def set_current_tab
    @current_tab = :customers
  end
end
