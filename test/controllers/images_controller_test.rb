require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @image1 = Image.create!(url: 'http://www.getty.edu/museum/media/images/web/enlarge/00014501.jpg')
    @image2 = Image.create!(url: 'http://www.getty.edu/museum/media/images/web/enlarge/00106901.jpg')
  end

  def test_new
    get new_image_path

    assert_response :success
    assert_select '#header', 'Add an image'
  end

  def test_show
    get image_path(@image1)

    assert_response :ok
    assert_select '.image-show', src: @image1.url
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

  def test_index
    get images_index_path
    assert_select '.saved-image' do |images|
      assert_equal Image.count, images.count
      assert_equal images[0]['alt'], '00106901'
      assert_equal images[1]['alt'], '00014501'
    end
  end
end
