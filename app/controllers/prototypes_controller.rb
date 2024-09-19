class PrototypesController < ApplicationController
  def index
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    redirect_to prototype_path(prototype)
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end
end

private

def prototype_params
  params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
end
