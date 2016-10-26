class SearchWithUserService
  def initialize(searchable_class, user)
    @searchable_class = searchable_class
    @user = user
  end

  def search(params)
    if @user.admin?
      search_result = @searchable_class.search(params[:search]).page(params[:page])
    else
      search_result = @searchable_class.where(user: @current_user).search(params[:search]).page(params[:page])
    end

    search_result
  end
end

