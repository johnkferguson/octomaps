Octomaps::Admin.controllers :countries do
  get :index do
    @title = "Countries"
    @countries = Country.all
    render 'countries/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'country')
    @country = Country.new
    render 'countries/new'
  end

  post :create do
    @country = Country.new(params[:country])
    if @country.save
      @title = pat(:create_title, :model => "country #{@country.id}")
      flash[:success] = pat(:create_success, :model => 'Country')
      params[:save_and_continue] ? redirect(url(:countries, :index)) : redirect(url(:countries, :edit, :id => @country.id))
    else
      @title = pat(:create_title, :model => 'country')
      flash.now[:error] = pat(:create_error, :model => 'country')
      render 'countries/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "country #{params[:id]}")
    @country = Country.find(params[:id])
    if @country
      render 'countries/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'country', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "country #{params[:id]}")
    @country = Country.find(params[:id])
    if @country
      if @country.update_attributes(params[:country])
        flash[:success] = pat(:update_success, :model => 'Country', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:countries, :index)) :
          redirect(url(:countries, :edit, :id => @country.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'country')
        render 'countries/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'country', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Countries"
    country = Country.find(params[:id])
    if country
      if country.destroy
        flash[:success] = pat(:delete_success, :model => 'Country', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'country')
      end
      redirect url(:countries, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'country', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Countries"
    unless params[:country_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'country')
      redirect(url(:countries, :index))
    end
    ids = params[:country_ids].split(',').map(&:strip)
    countries = Country.find(ids)
    
    if Country.destroy countries
    
      flash[:success] = pat(:destroy_many_success, :model => 'Countries', :ids => "#{ids.to_sentence}")
    end
    redirect url(:countries, :index)
  end
end
