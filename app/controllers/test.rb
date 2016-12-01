HustLibrary::App.controllers :test do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  get :index, :map => '/' do
    @questions = Question.all
    @libraries = Library.all
    @roles = Survey::USER_ROLES
    @answers = Library::LIKERT_SCORES.map { |k, v| v }
    render 'test/index'
  end

  get :index, :map=>'/test' do
    @title = "Test"
    render 'test/test'
  end

  post :create do
    if (@advice.save rescue false)
      @title = pat(:create_title, :model => "advice #{@advice.id}")
      flash[:success] = pat(:create_success, :model => 'Advice')
      params[:save_and_continue] ? redirect(url(:advices, :index)) : redirect(url(:advices, :edit, :id => @advice.id))
    else
      @title = pat(:create_title, :model => 'advice')
      flash.now[:error] = pat(:create_error, :model => 'advice')
      render 'test/test'
    end
  end

  get :signup do
    "afiiwe"
  end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end


end
