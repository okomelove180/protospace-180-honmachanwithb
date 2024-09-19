class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update, :destroy] # showアクションにも使いたい場合は、only: [:show, :edit, :update, :destroy]とする

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    redirect_to root_path if current_user.id != @prototype.user_id
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @prototype.user_id == current_user.id
      if @prototype.destroy
        redirect_to root_path, notice: '削除が完了しました'
      else
        redirect_to prototype_path(@prototype), alert: '削除に失敗しました'
      end
    else
      redirect_to root_path, alert: '削除権限がありません'
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_item
    @prototype = Prototype.find(params[:id])
  end
end
