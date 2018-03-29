require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.create!(url: 'http://www.getty.edu/museum/media/images/web/enlarge/00106901.jpg')
  end

  def test_show
    get image_path(@image)

    assert_response :ok
    assert_select '.image-show', src: @image.url
  end
end
