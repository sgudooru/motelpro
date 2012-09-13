ActionController::Routing::Routes.draw do |map|
  resources :rooms
  resources :customers
  resources :users
  resources :checkins

  map.root :controller => 'dashboard', :action=> 'index'
  map.checkin '/checkin/:room_id/:customer_id/new', :controller=>'checkins', :action => 'checkin'
  map.checkout '/checkin/:id/checkout', :controller=>'checkins', :action => 'checkout'
  map.select 'checkin/:room_id/new', :controller=>'checkins', :action => 'select_customer'

  map.clear_room 'rooms/clear', :controller=>'rooms', :action => 'clear'
  map.clear_customer 'customers/clear', :controller=>'customers', :action => 'clear'
  map.clear_user 'users/clear', :controller=>'users', :action => 'clear'


  map.update_cust 'customers/:id/update', :controller=>'customers', :action => 'upd'
  map.update_room 'rooms/:id/update', :controller=>'rooms', :action => 'upd'
  map.update_user 'users/:id/update', :controller=>'users', :action => 'upd'

  map.customer_search 'checkins/:room_id/search', :controller => 'checkins', :action => 'search'

  map.rooms_destroy 'rooms/:id/destroy', :controller=>'rooms', :action => 'rooms_destroy'
  map.customers_destroy 'customers/:id/destroy', :controller=>'customers', :action => 'customers_destroy'
  map.users_destroy 'users/:id/destroy', :controller=>'users', :action => 'users_destroy'

  map.user_report 'users/:id/report', :controller=>'users', :action => 'report'
  map.user_day_report 'users/day_report', :controller=>'users', :action => 'day_report'

  map.db_show_room 'dashboard/:id/room', :controller=>'dashboard', :action => 'show_room'
  map.db_change_room 'dashboard/:id/change_room', :controller=>'dashboard', :action => 'change_room'

  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.resources :dashboard, :only => :index

  map.resources :users

  map.resource :user_session

  map.connect '*url', :controller => 'dashboard', :action => 'index'

end
