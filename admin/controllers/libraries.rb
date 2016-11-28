HustLibrary::Admin.controllers :libraries do
  get :index do
    @title = "Libraries"
    @libraries = Library.all
    render 'libraries/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'library')
    @library = Library.new
    render 'libraries/new'
  end

  post :create do
    @library = Library.new(params[:library])
    if (@library.save rescue false)
      @title = pat(:create_title, :model => "library #{@library.id}")
      flash[:success] = pat(:create_success, :model => 'Library')
      params[:save_and_continue] ? redirect(url(:libraries, :index)) : redirect(url(:libraries, :edit, :id => @library.id))
    else
      @title = pat(:create_title, :model => 'library')
      flash.now[:error] = pat(:create_error, :model => 'library')
      render 'libraries/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "library #{params[:id]}")
    @library = Library[params[:id]]
    if @library
      render 'libraries/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'library', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "library #{params[:id]}")
    @library = Library[params[:id]]
    if @library
      if @library.modified! && @library.update(params[:library])
        flash[:success] = pat(:update_success, :model => 'Library', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:libraries, :index)) :
          redirect(url(:libraries, :edit, :id => @library.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'library')
        render 'libraries/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'library', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Libraries"
    library = Library[params[:id]]
    if library
      if library.destroy
        flash[:success] = pat(:delete_success, :model => 'Library', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'library')
      end
      redirect url(:libraries, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'library', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Libraries"
    unless params[:library_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'library')
      redirect(url(:libraries, :index))
    end
    ids = params[:library_ids].split(',').map(&:strip)
    libraries = Library.where(:id => ids)
    
    if libraries.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Libraries', :ids => "#{ids.join(', ')}")
    end
    redirect url(:libraries, :index)
  end
end
