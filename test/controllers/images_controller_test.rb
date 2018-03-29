require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image = Image.create!(url: 'http://www.getty.edu/museum/media/images/web/enlarge/00106901.jpg')
  end

  def test_new
    get new_image_path

    assert_response :success
    assert_select '#header', 'Add an image'
  end

  def test_show
    get image_path(@image)

    assert_response :ok
    assert_select '.image-show', src: @image.url
  end

  def test_create__succeed
    assert_difference('Image.count', 1) do
      image_params = { url: 'http://media.getty.edu/museum/images/web/enlarge/00094701.jpg' }
      post images_path, params: { image: image_params }
    end
    assert_equal 'The image is successfully added.', flash[:notice]
  end

  def test_create__fail
    assert_no_difference('Image.count') do
      image_params = { url: 'ftp://media.getty.edu/museum/images/web/enlarge/00094701.jpg' }
      post images_path, params: { image: image_params }
    end

    assert_response :ok
    assert_select '#error_explanation ul li', 'Url Errors: Invalid URL!'
  end
end
