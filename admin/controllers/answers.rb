HustLibrary::Admin.controllers :answers do
  get :index do
    @title = "Answers"
    @answers = Answer.all
    render 'answers/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'answer')
    @answer = Answer.new
    render 'answers/new'
  end

  post :create do
    @answer = Answer.new(params[:answer])
    if (@answer.save rescue false)
      @title = pat(:create_title, :model => "answer #{@answer.id}")
      flash[:success] = pat(:create_success, :model => 'Answer')
      params[:save_and_continue] ? redirect(url(:answers, :index)) : redirect(url(:answers, :edit, :id => @answer.id))
    else
      @title = pat(:create_title, :model => 'answer')
      flash.now[:error] = pat(:create_error, :model => 'answer')
      render 'answers/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "answer #{params[:id]}")
    @answer = Answer[params[:id]]
    if @answer
      render 'answers/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'answer', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "answer #{params[:id]}")
    @answer = Answer[params[:id]]
    if @answer
      if @answer.modified! && @answer.update(params[:answer])
        flash[:success] = pat(:update_success, :model => 'Answer', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:answers, :index)) :
          redirect(url(:answers, :edit, :id => @answer.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'answer')
        render 'answers/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'answer', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Answers"
    answer = Answer[params[:id]]
    if answer
      if answer.destroy
        flash[:success] = pat(:delete_success, :model => 'Answer', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'answer')
      end
      redirect url(:answers, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'answer', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Answers"
    unless params[:answer_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'answer')
      redirect(url(:answers, :index))
    end
    ids = params[:answer_ids].split(',').map(&:strip)
    answers = Answer.where(:id => ids)
    
    if answers.destroy
    
      flash[:success] = pat(:destroy_many_success, :model => 'Answers', :ids => "#{ids.join(', ')}")
    end
    redirect url(:answers, :index)
  end
end
