HustLibrary::Admin.controllers :advices do
  get :index do
    @title = "Advices"
    @advices = Advice.all
    render 'advices/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'advice')
    @advice = Advice.new
    render 'advices/new'
  end

  post :create do
    @advice = Advice.new(params[:advice])
    if (@advice.save rescue false)
      @title = pat(:create_title, :model => "advice #{@advice.id}")
      flash[:success] = pat(:create_success, :model => 'Advice')
      params[:save_and_continue] ? redirect(url(:advices, :index)) : redirect(url(:advices, :edit, :id => @advice.id))
    else
      @title = pat(:create_title, :model => 'advice')
      flash.now[:error] = pat(:create_error, :model => 'advice')
      render 'advices/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "advice #{params[:id]}")
    @advice = Advice[params[:id]]
    if @advice
      render 'advices/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'advice', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "advice #{params[:id]}")
    @advice = Advice[params[:id]]
    if @advice
      if @advice.modified! && @advice.update(params[:advice])
        flash[:success] = pat(:update_success, :model => 'Advice', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:advices, :index)) :
          redirect(url(:advices, :edit, :id => @advice.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'advice')
        render 'advices/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'advice', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Advices"
    advice = Advice[params[:id]]
    if advice
      if advice.destroy
        flash[:success] = pat(:delete_success, :model => 'Advice', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'advice')
      end
      redirect url(:advices, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'advice', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Advices"
    unless params[:advice_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'advice')
      redirect(url(:advices, :index))
    end
    ids = params[:advice_ids].split(',').map(&:strip)
    advices = Advice.where(:id => ids)
    
    if advices.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Advices', :ids => "#{ids.join(', ')}")
    end
    redirect url(:advices, :index)
  end
end
