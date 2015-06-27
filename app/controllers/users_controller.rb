class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @users = User.search(params[:search]).page(params[:page])
    respond_with(@users)
  end

  def show
    respond_with(@user)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    if @user.save
      redirect_to users_path, flash: { success: 'Usuário cadastro com sucesso' }
    else
      error_msg = ''
      @user.errors.full_messages.each do |msg|
        error_msg << "<div>#{msg}</div>"
      end
      redirect_to new_user_path, flash: { error: error_msg }
    end
  end

  def update
    if @user.update(check_password(user_params))
      redirect_to users_path, flash: { success: 'Usuário atualizado com sucesso' }
    else
      error_msg = ''
      @user.errors.full_messages.each do |msg|
        error_msg << "<div>#{msg}</div>"
      end
      redirect_to edit_user_path, flash: { error: error_msg }
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, flash: { success: 'Usuário excluído com sucesso' }
    else
      redirect_to users_path, flash: { error: 'Erro ao excluir usuário' }
    end
  end

  def profile
    @user = User.find(current_user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def check_password(user_params)
      if user_params[:password].empty?
        user_params.delete(:password)
        user_params.delete(:password_confirmation)
        user_params
      else
        user_params
      end
    end

    def user_params
      params.require(:user).permit(
        :name, :admin, :email, :password, :password_confirmation, :status
      )
    end
end
