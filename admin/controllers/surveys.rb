HustLibrary::Admin.controllers :surveys do
  get :index do
    @title = "Surveys"
    @surveys = Survey.all
    render 'surveys/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'survey')
    @survey = Survey.new
    render 'surveys/new'
  end

  post :create do
    @survey = Survey.new(params[:survey])
    if (@survey.save rescue false)
      @title = pat(:create_title, :model => "survey #{@survey.id}")
      flash[:success] = pat(:create_success, :model => 'Survey')
      params[:save_and_continue] ? redirect(url(:surveys, :index)) : redirect(url(:surveys, :edit, :id => @survey.id))
    else
      @title = pat(:create_title, :model => 'survey')
      flash.now[:error] = pat(:create_error, :model => 'survey')
      render 'surveys/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "survey #{params[:id]}")
    @survey = Survey[params[:id]]
    if @survey
      render 'surveys/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'survey', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "survey #{params[:id]}")
    @survey = Survey[params[:id]]
    if @survey
      if @survey.modified! && @survey.update(params[:survey])
        flash[:success] = pat(:update_success, :model => 'Survey', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:surveys, :index)) :
          redirect(url(:surveys, :edit, :id => @survey.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'survey')
        render 'surveys/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'survey', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Surveys"
    survey = Survey[params[:id]]
    if survey
      if survey.destroy
        flash[:success] = pat(:delete_success, :model => 'Survey', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'survey')
      end
      redirect url(:surveys, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'survey', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Surveys"
    unless params[:survey_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'survey')
      redirect(url(:surveys, :index))
    end
    ids = params[:survey_ids].split(',').map(&:strip)
    surveys = Survey.where(:id => ids)
    
    if surveys.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Surveys', :ids => "#{ids.join(', ')}")
    end
    redirect url(:surveys, :index)
  end
end
