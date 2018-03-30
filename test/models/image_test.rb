require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def test_image__valid
    image = Image.new(url: 'http://www.getty.edu/museum/media/images/web/enlarge/00014501.jpg')

    assert_predicate image, :valid?
  end

  def test_image__invalid_if_url_is_blank
    image = Image.new

    refute_predicate image, :valid?
    assert_equal "can't be blank", image.errors.messages[:url].first
  end

  def test_image__invalid_if_url_is_nil
    image = Image.new(url: nil)

    refute_predicate image, :valid?
    assert_equal "can't be blank", image.errors.messages[:url].first
  end

  def test_image__invalid_if_is_not_url
    image = Image.new(url: 'ftp://dsafljrwklf.jpg')

    refute_predicate image, :valid?
    assert_equal 'Errors: Invalid URL!', image.errors.messages[:url].first
  end

  def test_image__invalid_if_is_not_image
    image = Image.new(url: 'http://www.getty.edu/museum/media/images/web/enlarge/00014501')

    refute_predicate image, :valid?
    assert_equal 'Errors: Invalid Image URL. We only accept .png/.jpeg/.jpg/.gif files.',
                 image.errors.messages[:url].first
  end

  def test_image__invalid_if_neither_url_nor_image
    image = Image.new(url: 'nonsense')

    refute_predicate image, :valid?
    assert_equal 'Errors: Invalid Image URL. We only accept .png/.jpeg/.jpg/.gif files.',
                 image.errors.messages[:url].first
    assert_equal 'Errors: Invalid URL!', image.errors.messages[:url].last
    assert_equal image.errors.count, 2
  end
end
