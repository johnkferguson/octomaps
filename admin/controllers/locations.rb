Octomaps::Admin.controllers :locations do
  get :index do
    @title = "Locations"
    @locations = Location.all
    render 'locations/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'location')
    @location = Location.new
    render 'locations/new'
  end

  post :create do
    @location = Location.new(params[:location])
    if @location.save
      @title = pat(:create_title, :model => "location #{@location.id}")
      flash[:success] = pat(:create_success, :model => 'Location')
      params[:save_and_continue] ? redirect(url(:locations, :index)) : redirect(url(:locations, :edit, :id => @location.id))
    else
      @title = pat(:create_title, :model => 'location')
      flash.now[:error] = pat(:create_error, :model => 'location')
      render 'locations/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "location #{params[:id]}")
    @location = Location.find(params[:id])
    if @location
      render 'locations/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'location', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "location #{params[:id]}")
    @location = Location.find(params[:id])
    if @location
      if @location.update_attributes(params[:location])
        flash[:success] = pat(:update_success, :model => 'Location', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:locations, :index)) :
          redirect(url(:locations, :edit, :id => @location.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'location')
        render 'locations/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'location', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Locations"
    location = Location.find(params[:id])
    if location
      if location.destroy
        flash[:success] = pat(:delete_success, :model => 'Location', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'location')
      end
      redirect url(:locations, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'location', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Locations"
    unless params[:location_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'location')
      redirect(url(:locations, :index))
    end
    ids = params[:location_ids].split(',').map(&:strip)
    locations = Location.find(ids)
    
    if Location.destroy locations
    
      flash[:success] = pat(:destroy_many_success, :model => 'Locations', :ids => "#{ids.to_sentence}")
    end
    redirect url(:locations, :index)
  end
end
