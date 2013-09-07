Octomaps::Admin.controllers :contributions do
  get :index do
    @title = "Contributions"
    @contributions = Contribution.all
    render 'contributions/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'contribution')
    @contribution = Contribution.new
    render 'contributions/new'
  end

  post :create do
    @contribution = Contribution.new(params[:contribution])
    if @contribution.save
      @title = pat(:create_title, :model => "contribution #{@contribution.id}")
      flash[:success] = pat(:create_success, :model => 'Contribution')
      params[:save_and_continue] ? redirect(url(:contributions, :index)) : redirect(url(:contributions, :edit, :id => @contribution.id))
    else
      @title = pat(:create_title, :model => 'contribution')
      flash.now[:error] = pat(:create_error, :model => 'contribution')
      render 'contributions/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "contribution #{params[:id]}")
    @contribution = Contribution.find(params[:id])
    if @contribution
      render 'contributions/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'contribution', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "contribution #{params[:id]}")
    @contribution = Contribution.find(params[:id])
    if @contribution
      if @contribution.update_attributes(params[:contribution])
        flash[:success] = pat(:update_success, :model => 'Contribution', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:contributions, :index)) :
          redirect(url(:contributions, :edit, :id => @contribution.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'contribution')
        render 'contributions/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'contribution', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Contributions"
    contribution = Contribution.find(params[:id])
    if contribution
      if contribution.destroy
        flash[:success] = pat(:delete_success, :model => 'Contribution', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'contribution')
      end
      redirect url(:contributions, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'contribution', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Contributions"
    unless params[:contribution_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'contribution')
      redirect(url(:contributions, :index))
    end
    ids = params[:contribution_ids].split(',').map(&:strip)
    contributions = Contribution.find(ids)
    
    if Contribution.destroy contributions
    
      flash[:success] = pat(:destroy_many_success, :model => 'Contributions', :ids => "#{ids.to_sentence}")
    end
    redirect url(:contributions, :index)
  end
end
