class ImagesController < ApplicationController
  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    if @image.save
      redirect_to image_path(@image), notice: 'The image is successfully added.'
    else
      render 'new'
    end
  end

  private

  def image_params
    params.require(:image).permit(:url)
  end
end
