HustLibrary::App.controllers :test do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  get :index, :map=>'/' do
    @questions = Question.all
    @libraries = Library.all
    @roles = Survey::USER_ROLES
    @answers = Library::LIKERT_SCORES.map {|k, v| v}
    render 'test/index'
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